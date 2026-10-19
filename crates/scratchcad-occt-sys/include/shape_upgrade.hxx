#include <ShapeExtend_Status.hxx>
#include <ShapeUpgrade_ShapeConvertToBezier.hxx>
#include <ShapeUpgrade_UnifySameDomain.hxx>
#include <bindings_common.hxx>

// A copy of `shape` whose curves and surfaces are split into Bézier segments and patches, one
// per span of a B-spline. Integrating each patch with a fixed number of Gauss points is then
// accurate, where a whole B-spline face with many spans is not. Throws if the conversion fails,
// rather than returning a shape that measures wrong.
inline std::unique_ptr<TopoDS_Shape> ShapeUpgrade_convert_to_bezier(const TopoDS_Shape &shape) {
  ShapeUpgrade_ShapeConvertToBezier convert(shape);
  convert.Set2dConversion(Standard_True);
  convert.Set3dConversion(Standard_True);
  convert.SetSurfaceConversion(Standard_True);
  convert.SetPlaneMode(Standard_True);
  convert.SetRevolutionMode(Standard_True);
  convert.SetExtrusionMode(Standard_True);
  convert.SetBSplineMode(Standard_True);
  convert.Perform();
  TopoDS_Shape result = convert.Result();
  if (convert.Status(ShapeExtend_FAIL) || result.IsNull()) {
    throw Standard_Failure("could not split the shape into Bézier patches");
  }
  return std::make_unique<TopoDS_Shape>(result);
}
