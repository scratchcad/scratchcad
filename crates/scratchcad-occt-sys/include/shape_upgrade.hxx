#include <BRepBuilderAPI_Copy.hxx>
#include <ShapeExtend_Status.hxx>
#include <ShapeUpgrade_ShapeConvertToBezier.hxx>
#include <ShapeUpgrade_ShapeDivideClosed.hxx>
#include <ShapeUpgrade_UnifySameDomain.hxx>
#include <bindings_common.hxx>

// A copy of `shape` whose curves and surfaces are split into Bézier segments and patches, one
// per span of a B-spline. Integrating each patch with a fixed number of Gauss points is then
// accurate, where a whole B-spline face with many spans is not. Throws if the conversion fails,
// rather than returning a shape that measures wrong.
//
// The conversion edits the sub-shapes it splits in place, and shapes share sub-shapes (a boolean's
// result shares the untouched faces of its arguments), so it works on a deep copy: otherwise
// measuring one shape could break another. Closed faces, such as a torus or a full cylinder, are
// cut open first, as splitting the edges of a face that wraps around corrupts its boundary (a torus
// trimmed by B-spline edges measured with a negative area).
//
// The surfaces and the curves are converted in two calls, checking each: one call does both in
// two passes, and the curve pass resets the status, which hides a failed surface pass.
inline std::unique_ptr<TopoDS_Shape> ShapeUpgrade_convert_to_bezier(const TopoDS_Shape &shape) {
  BRepBuilderAPI_Copy copy(shape, Standard_True, Standard_False);
  ShapeUpgrade_ShapeDivideClosed divide(copy.Shape());
  divide.SetNbSplitPoints(1);
  divide.Perform();
  ShapeUpgrade_ShapeConvertToBezier convert(divide.Result());
  auto check = [&convert]() {
    if (convert.Status(ShapeExtend_FAIL) || convert.Result().IsNull()) {
      throw Standard_Failure("could not split the shape into Bézier patches");
    }
  };
  convert.SetPlaneMode(Standard_True);
  convert.SetRevolutionMode(Standard_True);
  convert.SetExtrusionMode(Standard_True);
  convert.SetBSplineMode(Standard_True);

  convert.SetSurfaceConversion(Standard_True);
  convert.Set2dConversion(Standard_False);
  convert.Set3dConversion(Standard_False);
  convert.Perform();
  check();

  // Carries on from the surface pass's result, in the same context.
  convert.SetSurfaceConversion(Standard_False);
  convert.Set2dConversion(Standard_True);
  convert.Set3dConversion(Standard_True);
  convert.Perform(Standard_False);
  check();
  return std::make_unique<TopoDS_Shape>(convert.Result());
}
