#include <BRepBuilderAPI_MakeFace.hxx>
#include <BRepFill_CompatibleWires.hxx>
#include <BRepGProp.hxx>
#include <BRepTools_WireExplorer.hxx>
#include <BRep_Builder.hxx>
#include <BRep_Tool.hxx>
#include <BSplCLib.hxx>
#include <GProp_GProps.hxx>
#include <Geom2d_Line.hxx>
#include <GeomConvert.hxx>
#include <GeomConvert_CompCurveToBSplineCurve.hxx>
#include <GeomFill_SectionGenerator.hxx>
#include <Geom_BSplineCurve.hxx>
#include <Geom_BSplineSurface.hxx>
#include <Geom_OffsetCurve.hxx>
#include <Geom_TrimmedCurve.hxx>
#include <Precision.hxx>
#include <Standard_ConstructionError.hxx>
#include <TColStd_Array1OfInteger.hxx>
#include <TColStd_Array1OfReal.hxx>
#include <TColStd_Array2OfReal.hxx>
#include <TColgp_Array1OfPnt.hxx>
#include <TColgp_Array2OfPnt.hxx>
#include <TopExp_Explorer.hxx>
#include <TopTools_ListOfShape.hxx>
#include <TopTools_SequenceOfShape.hxx>
#include <TopoDS.hxx>
#include <TopoDS_Shell.hxx>
#include <TopoDS_Solid.hxx>
#include <bindings_common.hxx>
#include <gp_Pln.hxx>
#include <vector>

// The sections of a smooth loft as B-spline curves sharing a degree and knots, so that the loft is
// a B-spline surface through them, and its edges match up: a section of several edges runs over
// [0, edges], its edge j over [j, j + 1].
class LoftSections {
public:
  int32_t u_degree = 0, edges = 0, sections = 0, poles_per_section = 0;
  bool closed = true;
  std::vector<double> knots, poles, weights;
  std::vector<int32_t> mults;

  int32_t degree() const { return u_degree; }
  int32_t edge_count() const { return edges; }
  int32_t section_count() const { return sections; }
  int32_t pole_count() const { return poles_per_section; }
  bool is_closed() const { return closed; }
  const std::vector<double> &knot_values() const { return knots; }
  const std::vector<int32_t> &knot_mults() const { return mults; }
  // x, y, z of every pole, section by section.
  const std::vector<double> &pole_coords() const { return poles; }
  const std::vector<double> &pole_weights() const { return weights; }
};

inline int loft_edge_count(const TopoDS_Wire &wire) {
  int n = 0;
  for (BRepTools_WireExplorer ex(wire); ex.More(); ex.Next()) {
    n++;
  }
  return n;
}

// A wire as one B-spline, exactly: conics are converted with a rational parametrization that is
// smooth throughout (Convert_QuasiAngular), not one of arcs joined end to end.
inline Handle(Geom_BSplineCurve) loft_wire_curve(const TopoDS_Wire &wire) {
  Handle(Geom_BSplineCurve) all;
  int j = 0;
  for (BRepTools_WireExplorer ex(wire); ex.More(); ex.Next(), j++) {
    const TopoDS_Edge &edge = ex.Current();
    Standard_Real a, b;
    Handle(Geom_Curve) curve = BRep_Tool::Curve(edge, a, b);
    if (curve.IsNull()) {
      throw Standard_ConstructionError("an edge of a section has no curve");
    }
    Handle(Geom_Curve) basis = curve;
    while (basis->IsKind(STANDARD_TYPE(Geom_TrimmedCurve))) {
      basis = Handle(Geom_TrimmedCurve)::DownCast(basis)->BasisCurve();
    }
    // OpenCASCADE only approximates offset curves as B-splines.
    if (basis->IsKind(STANDARD_TYPE(Geom_OffsetCurve))) {
      throw Standard_ConstructionError("an edge of a section is an offset curve, which can't be lofted exactly");
    }
    Handle(Geom_BSplineCurve) piece =
        GeomConvert::CurveToBSplineCurve(new Geom_TrimmedCurve(curve, a, b), Convert_QuasiAngular);
    if (ex.Orientation() == TopAbs_REVERSED) {
      piece->Reverse();
    }
    TColStd_Array1OfReal knots(1, piece->NbKnots());
    piece->Knots(knots);
    BSplCLib::Reparametrize(j, j + 1, knots);
    piece->SetKnots(knots);
    if (all.IsNull()) {
      all = piece;
    } else {
      GeomConvert_CompCurveToBSplineCurve join(all);
      if (!join.Add(piece, Precision::Confusion(), Standard_True, Standard_False, 0)) {
        throw Standard_ConstructionError("the edges of a section don't join end to end");
      }
      all = join.BSplineCurve();
    }
  }
  if (all.IsNull()) {
    throw Standard_ConstructionError("a section has no edges");
  }
  return all;
}

// The sections as compatible B-splines. With `match_edges`, the wires are first given the same
// number of edges, split where the others' vertices are, and matching starting points, as
// OpenCASCADE's lofts do; otherwise each must be one closed edge, joined start to start.
inline std::unique_ptr<LoftSections> BRepFill_loft_sections(const TopTools_ListOfShape &wires, bool match_edges) {
  std::vector<TopoDS_Wire> sections;
  for (TopTools_ListOfShape::Iterator it(wires); it.More(); it.Next()) {
    sections.push_back(TopoDS::Wire(it.Value()));
  }
  if (match_edges) {
    TopTools_SequenceOfShape seq;
    for (const TopoDS_Wire &w : sections) {
      seq.Append(w);
    }
    BRepFill_CompatibleWires compatible(seq);
    // Split edges where another section has a vertex unless one is within 1% of the edge's
    // length: at the default 10% the matching gives up on sections such as a circle between
    // rounded rectangles.
    compatible.SetPercent(0.01);
    compatible.Perform(Standard_True);
    if (!compatible.IsDone()) {
      throw Standard_ConstructionError("the sections' edges could not be matched up");
    }
    sections.clear();
    for (int i = 1; i <= compatible.Shape().Length(); i++) {
      sections.push_back(TopoDS::Wire(compatible.Shape()(i)));
    }
  }
  auto result = std::make_unique<LoftSections>();
  result->sections = static_cast<int32_t>(sections.size());
  result->edges = loft_edge_count(sections.front());
  GeomFill_SectionGenerator generator;
  for (const TopoDS_Wire &w : sections) {
    result->closed = result->closed && w.Closed();
    if (loft_edge_count(w) != result->edges) {
      throw Standard_ConstructionError("the sections have different numbers of edges");
    }
    generator.AddCurve(loft_wire_curve(w));
  }
  generator.Perform(Precision::PConfusion());
  Standard_Integer nu, nk, degree, nu2d;
  generator.GetShape(nu, nk, degree, nu2d);
  result->u_degree = degree;
  result->poles_per_section = nu;
  TColStd_Array1OfReal knots(1, nk);
  TColStd_Array1OfInteger mults(1, nk);
  generator.KnotsAndMults(knots, mults);
  for (int i = 1; i <= nk; i++) {
    result->knots.push_back(knots(i));
    result->mults.push_back(mults(i));
  }
  for (int k = 1; k <= result->sections; k++) {
    TColgp_Array1OfPnt poles(1, nu);
    TColStd_Array1OfReal weights(1, nu);
    generator.Poles(k, poles);
    generator.Weights(k, weights);
    for (int i = 1; i <= nu; i++) {
      result->poles.push_back(poles(i).X());
      result->poles.push_back(poles(i).Y());
      result->poles.push_back(poles(i).Z());
      result->weights.push_back(weights(i));
    }
  }
  return result;
}

// The planar face bounded by `wire`, on the plane through it that it runs counter-clockwise about.
inline TopoDS_Face loft_cap(const TopoDS_Wire &wire) {
  std::vector<gp_Pnt> points;
  for (BRepTools_WireExplorer ex(wire); ex.More(); ex.Next()) {
    Standard_Real a, b;
    Handle(Geom_Curve) curve = BRep_Tool::Curve(ex.Current(), a, b);
    bool reversed = ex.Current().Orientation() == TopAbs_REVERSED;
    for (int q = 0; q < 16; q++) {
      points.push_back(curve->Value(reversed ? b - (b - a) * q / 16 : a + (b - a) * q / 16));
    }
  }
  gp_XYZ centre(0, 0, 0), normal(0, 0, 0);
  for (const gp_Pnt &p : points) {
    centre += p.XYZ();
  }
  centre /= static_cast<double>(points.size());
  for (size_t q = 0; q < points.size(); q++) {
    normal += (points[q].XYZ() - centre).Crossed(points[(q + 1) % points.size()].XYZ() - centre);
  }
  double span = 0;
  for (const gp_Pnt &p : points) {
    span = std::max(span, p.Distance(gp_Pnt(centre)));
  }
  if (normal.Modulus() <= 1e-12 * span * span) {
    throw Standard_ConstructionError("an end section of a solid loft must enclose an area");
  }
  gp_Pln plane = gp_Pln(gp_Pnt(centre), gp_Dir(normal));
  for (const gp_Pnt &p : points) {
    if (plane.Distance(p) > 1e-9 * std::max(1.0, span)) {
      throw Standard_ConstructionError("an end section of a solid loft must lie in a plane");
    }
  }
  BRepBuilderAPI_MakeFace cap(plane, wire, Standard_True);
  if (!cap.IsDone()) {
    throw Standard_ConstructionError("an end section of a solid loft could not be made into a face");
  }
  return cap.Face();
}

// A loft's shape from its surface: one face per edge of the sections (u from j to j + 1) and per
// stretch between consecutive `cuts` in v, whose edges are the surface's own iso-curves, shared by
// the faces either side, with their curves on the faces as straight lines in (u, v): so they are
// exact, unlike edges sewn together. Closed into a solid by planar faces at the ends, facing out.
// `poles` holds x, y, z of each pole, all of a u index's poles in v order before the next's.
inline std::unique_ptr<TopoDS_Shape>
BRepFill_loft_shape(int32_t u_degree, rust::Slice<const double> u_knots, rust::Slice<const int32_t> u_mults,
                    int32_t v_degree, rust::Slice<const double> v_knots, rust::Slice<const int32_t> v_mults,
                    rust::Slice<const double> poles, rust::Slice<const double> weights, int32_t edges, bool closed,
                    rust::Slice<const double> cuts, bool solid) {
  int nuk = static_cast<int>(u_knots.size()), nvk = static_cast<int>(v_knots.size());
  int sum_u = 0, sum_v = 0;
  for (int32_t m : u_mults) {
    sum_u += m;
  }
  for (int32_t m : v_mults) {
    sum_v += m;
  }
  int nu = sum_u - u_degree - 1, nv = sum_v - v_degree - 1;
  if (nu <= 0 || nv <= 0 || u_mults.size() != u_knots.size() || v_mults.size() != v_knots.size() ||
      static_cast<int>(weights.size()) != nu * nv || static_cast<int>(poles.size()) != 3 * nu * nv || cuts.size() < 2 ||
      edges < 1) {
    throw Standard_ConstructionError("the loft's surface data don't fit together");
  }
  TColgp_Array2OfPnt p(1, nu, 1, nv);
  TColStd_Array2OfReal w(1, nu, 1, nv);
  for (int i = 0; i < nu; i++) {
    for (int j = 0; j < nv; j++) {
      size_t at = static_cast<size_t>(i) * nv + j;
      p(i + 1, j + 1) = gp_Pnt(poles[3 * at], poles[3 * at + 1], poles[3 * at + 2]);
      w(i + 1, j + 1) = weights[at];
    }
  }
  TColStd_Array1OfReal uk(1, nuk), vk(1, nvk);
  TColStd_Array1OfInteger um(1, nuk), vm(1, nvk);
  for (int i = 0; i < nuk; i++) {
    uk(i + 1) = u_knots[i];
    um(i + 1) = u_mults[i];
  }
  for (int i = 0; i < nvk; i++) {
    vk(i + 1) = v_knots[i];
    vm(i + 1) = v_mults[i];
  }
  Handle(Geom_BSplineSurface) surface =
      new Geom_BSplineSurface(p, w, uk, vk, um, vm, u_degree, v_degree, Standard_False, Standard_False);

  const double tol = Precision::Confusion();
  const int nc = static_cast<int>(cuts.size());
  const int rails = closed ? edges : edges + 1;
  auto rail_index = [&](int j) { return closed ? j % edges : j; };
  BRep_Builder builder;
  std::vector<std::vector<TopoDS_Vertex>> vertices(rails, std::vector<TopoDS_Vertex>(nc));
  for (int j = 0; j < rails; j++) {
    for (int c = 0; c < nc; c++) {
      builder.MakeVertex(vertices[j][c], surface->Value(j, cuts[c]), tol);
    }
  }
  // Rails: u = j, between consecutive cuts.
  std::vector<std::vector<TopoDS_Edge>> rail(rails, std::vector<TopoDS_Edge>(nc - 1));
  for (int j = 0; j < rails; j++) {
    Handle(Geom_Curve) iso = surface->UIso(j);
    for (int c = 0; c + 1 < nc; c++) {
      builder.MakeEdge(rail[j][c], iso, tol);
      builder.Add(rail[j][c], vertices[j][c].Oriented(TopAbs_FORWARD));
      builder.Add(rail[j][c], vertices[j][c + 1].Oriented(TopAbs_REVERSED));
      builder.Range(rail[j][c], cuts[c], cuts[c + 1]);
    }
  }
  // Across: v = cuts[c], one per edge of the sections.
  std::vector<std::vector<TopoDS_Edge>> across(edges, std::vector<TopoDS_Edge>(nc));
  for (int c = 0; c < nc; c++) {
    Handle(Geom_Curve) iso = surface->VIso(cuts[c]);
    for (int j = 0; j < edges; j++) {
      builder.MakeEdge(across[j][c], iso, tol);
      builder.Add(across[j][c], vertices[rail_index(j)][c].Oriented(TopAbs_FORWARD));
      builder.Add(across[j][c], vertices[rail_index(j + 1)][c].Oriented(TopAbs_REVERSED));
      builder.Range(across[j][c], j, j + 1);
    }
  }
  auto line = [](double x, double y, double dx, double dy) {
    return Handle(Geom2d_Line)(new Geom2d_Line(gp_Pnt2d(x, y), gp_Dir2d(dx, dy)));
  };
  TopoDS_Shell shell;
  builder.MakeShell(shell);
  for (int j = 0; j < edges; j++) {
    for (int c = 0; c + 1 < nc; c++) {
      double v0 = cuts[c], v1 = cuts[c + 1];
      Handle(Geom_BSplineSurface) piece = Handle(Geom_BSplineSurface)::DownCast(surface->Copy());
      if (edges > 1 || nc > 2) {
        piece->Segment(j, j + 1, v0, v1);
      }
      TopoDS_Face face;
      builder.MakeFace(face, piece, tol);
      builder.UpdateEdge(across[j][c], line(0, v0, 1, 0), face, tol);
      builder.UpdateEdge(across[j][c + 1], line(0, v1, 1, 0), face, tol);
      const TopoDS_Edge &left = rail[rail_index(j)][c], &right = rail[rail_index(j + 1)][c];
      if (left.IsSame(right)) {
        // One face around closed sections: the seam carries both curves, u = j + 1 forward.
        builder.UpdateEdge(left, line(j + 1, 0, 0, 1), line(j, 0, 0, 1), face, tol);
      } else {
        builder.UpdateEdge(left, line(j, 0, 0, 1), face, tol);
        builder.UpdateEdge(right, line(j + 1, 0, 0, 1), face, tol);
      }
      TopoDS_Wire wire;
      builder.MakeWire(wire);
      builder.Add(wire, across[j][c].Oriented(TopAbs_FORWARD));
      builder.Add(wire, right.Oriented(TopAbs_FORWARD));
      builder.Add(wire, across[j][c + 1].Oriented(TopAbs_REVERSED));
      builder.Add(wire, left.Oriented(TopAbs_REVERSED));
      builder.Add(face, wire);
      builder.Add(shell, face);
    }
  }
  if (!solid) {
    return std::make_unique<TopoDS_Shape>(shell);
  }
  if (!closed) {
    throw Standard_ConstructionError("a solid loft needs closed sections");
  }
  // Caps bounded by the same edges as the side faces, used the other way round.
  for (int end = 0; end < 2; end++) {
    TopoDS_Wire wire;
    builder.MakeWire(wire);
    if (end == 0) {
      for (int j = edges - 1; j >= 0; j--) {
        builder.Add(wire, across[j][0].Oriented(TopAbs_REVERSED));
      }
    } else {
      for (int j = 0; j < edges; j++) {
        builder.Add(wire, across[j][nc - 1].Oriented(TopAbs_FORWARD));
      }
    }
    wire.Closed(Standard_True);
    builder.Add(shell, loft_cap(wire));
  }
  shell.Closed(Standard_True);
  TopoDS_Solid result;
  builder.MakeSolid(result);
  builder.Add(result, shell);
  GProp_GProps props;
  BRepGProp::VolumeProperties(result, props);
  if (props.Mass() < 0) {
    // Face outwards: each face reversed, in a forward shell and solid.
    TopoDS_Shell out;
    builder.MakeShell(out);
    for (TopExp_Explorer ex(shell, TopAbs_FACE); ex.More(); ex.Next()) {
      builder.Add(out, ex.Current().Reversed());
    }
    out.Closed(Standard_True);
    builder.MakeSolid(result);
    builder.Add(result, out);
  }
  return std::make_unique<TopoDS_Shape>(result);
}
