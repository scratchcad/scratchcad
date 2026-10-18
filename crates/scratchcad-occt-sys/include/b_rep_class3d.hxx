// Point classification against solids (BRepClass3d).

#include <BRepClass3d_SolidClassifier.hxx>
#include <TopAbs_State.hxx>
#include <TopoDS_Shape.hxx>
#include <bindings_common.hxx>
#include <gp_Pnt.hxx>

// Whether `point` lies inside, outside or on the boundary (within `tolerance`) of `solid`.
inline TopAbs_State classify_point(const TopoDS_Shape &solid, const gp_Pnt &point, double tolerance) {
  BRepClass3d_SolidClassifier classifier(solid, point, tolerance);
  return classifier.State();
}
