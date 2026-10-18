// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <GCE2d_MakeSegment.hxx>
#include <GC_MakeArcOfCircle.hxx>
#include <GC_MakeSegment.hxx>
#include <Standard_ConstructionError.hxx>
#include <StdFail_NotDone.hxx>
#include <bindings_common.hxx>
#include <gp.hxx>
#include <gp_Pnt.hxx>
#include <gp_Pnt2d.hxx>

// OCCT's constructor builds a trimmed curve on a null line when the points coincide, which crashes.
inline std::unique_ptr<GC_MakeSegment> GC_MakeSegment_point_point(const gp_Pnt &p1, const gp_Pnt &p2) {
  if (p1.Distance(p2) <= gp::Resolution()) {
    throw Standard_ConstructionError("GC_MakeSegment: the points are coincident");
  }
  return std::unique_ptr<GC_MakeSegment>(new GC_MakeSegment(p1, p2));
}

// OCCT builds its release libraries with -DNo_Exception, which disables the `StdFail_NotDone_Raise_if`
// checks in `Value()`; check explicitly so failures surface as errors instead of null handles.
inline std::unique_ptr<Handle_Geom_TrimmedCurve> GC_MakeSegment_Value(const GC_MakeSegment &segment) {
  if (!segment.IsDone()) {
    throw StdFail_NotDone("GC_MakeSegment: the points are coincident");
  }
  return std::unique_ptr<Handle_Geom_TrimmedCurve>(new opencascade::handle<Geom_TrimmedCurve>(segment.Value()));
}

inline std::unique_ptr<Handle_Geom2d_TrimmedCurve> GCE2d_MakeSegment_point_point(const gp_Pnt2d &p1,
                                                                                 const gp_Pnt2d &p2) {
  GCE2d_MakeSegment segment(p1, p2);
  if (!segment.IsDone()) {
    throw StdFail_NotDone("GCE2d_MakeSegment: the points are coincident");
  }
  return std::unique_ptr<Handle_Geom2d_TrimmedCurve>(new opencascade::handle<Geom2d_TrimmedCurve>(segment.Value()));
}

inline std::unique_ptr<Handle_Geom_TrimmedCurve> GC_MakeArcOfCircle_Value(const GC_MakeArcOfCircle &arc) {
  if (!arc.IsDone()) {
    throw StdFail_NotDone("GC_MakeArcOfCircle: no circle passes through the points");
  }
  return std::unique_ptr<Handle_Geom_TrimmedCurve>(new opencascade::handle<Geom_TrimmedCurve>(arc.Value()));
}
