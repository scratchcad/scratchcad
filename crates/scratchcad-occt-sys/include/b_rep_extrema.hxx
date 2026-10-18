#include <BRepExtrema_DistShapeShape.hxx>
#include <Standard_OutOfRange.hxx>
#include <bindings_common.hxx>

inline void BRepExtrema_check_index(const BRepExtrema_DistShapeShape &dist, Standard_Integer index) {
  if (index < 1 || index > dist.NbSolution()) {
    throw Standard_OutOfRange("BRepExtrema_DistShapeShape: solution index out of range");
  }
}

inline std::unique_ptr<gp_Pnt> BRepExtrema_DistShapeShape_point_on_shape_1(const BRepExtrema_DistShapeShape &dist,
                                                                           Standard_Integer index) {
  BRepExtrema_check_index(dist, index);
  return std::unique_ptr<gp_Pnt>(new gp_Pnt(dist.PointOnShape1(index)));
}

inline std::unique_ptr<gp_Pnt> BRepExtrema_DistShapeShape_point_on_shape_2(const BRepExtrema_DistShapeShape &dist,
                                                                           Standard_Integer index) {
  BRepExtrema_check_index(dist, index);
  return std::unique_ptr<gp_Pnt>(new gp_Pnt(dist.PointOnShape2(index)));
}
