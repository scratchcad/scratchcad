#include <BRepMesh_IncrementalMesh.hxx>
#include <IMeshTools_Parameters.hxx>
#include <bindings_common.hxx>

// Meshes `shape` (writing the triangulation into its faces) with full control over the
// tolerances. `angle` is in radians.
inline std::unique_ptr<BRepMesh_IncrementalMesh> IncrementalMesh_with_parameters(const TopoDS_Shape &shape,
                                                                                 double deflection, double angle,
                                                                                 bool relative, bool parallel,
                                                                                 const Message_ProgressRange &range) {
  IMeshTools_Parameters parameters;
  parameters.Deflection = deflection;
  parameters.Angle = angle;
  parameters.Relative = relative;
  parameters.InParallel = parallel;
  return std::unique_ptr<BRepMesh_IncrementalMesh>(new BRepMesh_IncrementalMesh(shape, parameters, range));
}
