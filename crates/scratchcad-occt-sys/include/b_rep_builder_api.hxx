#include <BRepBuilderAPI_Copy.hxx>
#include <BRepBuilderAPI_GTransform.hxx>
#include <BRepBuilderAPI_MakeEdge.hxx>
#include <BRepBuilderAPI_MakeFace.hxx>
#include <BRepBuilderAPI_MakeShapeOnMesh.hxx>
#include <BRepBuilderAPI_MakeSolid.hxx>
#include <BRepBuilderAPI_MakeVertex.hxx>
#include <BRepBuilderAPI_MakeWire.hxx>
#include <BRepBuilderAPI_Transform.hxx>
#include <Geom2d_Curve.hxx>
#include <Geom_Curve.hxx>
#include <Geom_Surface.hxx>
#include <bindings_common.hxx>

// A copy of `shape` with its own topology and geometry: algorithms that update a shape's data
// in place (meshing, tolerance updates) can run on the copy without affecting the original or
// any shape sharing its sub-shapes. Triangulations are not copied.
inline std::unique_ptr<TopoDS_Shape> BRepBuilderAPI_copy_shape(const TopoDS_Shape &shape) {
  BRepBuilderAPI_Copy copy(shape, Standard_True, Standard_False);
  return std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape(copy.Shape()));
}
