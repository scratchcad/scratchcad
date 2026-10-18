// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <BRepAlgoAPI_Common.hxx>
#include <BRepAlgoAPI_Cut.hxx>
#include <BRepAlgoAPI_Fuse.hxx>
#include <BRepAlgoAPI_Section.hxx>
#include <TopTools_ListOfShape.hxx>
#include <bindings_common.hxx>

// Runs a boolean operation in OpenCASCADE's "safe processing mode", which never modifies the
// arguments (by default the operation may, for example, raise the tolerances of their
// sub-shapes). The operation stops early when `range` asks it to. Returns null if it fails.
template <typename Operation>
std::unique_ptr<TopoDS_Shape> run_boolean(const TopoDS_Shape &argument, const TopoDS_Shape &tool,
                                          const Message_ProgressRange &range) {
  TopTools_ListOfShape arguments;
  arguments.Append(argument);
  TopTools_ListOfShape tools;
  tools.Append(tool);
  Operation operation;
  operation.SetArguments(arguments);
  operation.SetTools(tools);
  operation.SetNonDestructive(Standard_True);
  operation.Build(range);
  if (!operation.IsDone() || operation.HasErrors()) {
    return std::unique_ptr<TopoDS_Shape>(nullptr);
  }
  return std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape(operation.Shape()));
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_fuse(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                      const Message_ProgressRange &range) {
  return run_boolean<BRepAlgoAPI_Fuse>(a, b, range);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_cut(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                     const Message_ProgressRange &range) {
  return run_boolean<BRepAlgoAPI_Cut>(a, b, range);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_common(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                        const Message_ProgressRange &range) {
  return run_boolean<BRepAlgoAPI_Common>(a, b, range);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_section(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                         const Message_ProgressRange &range) {
  return run_boolean<BRepAlgoAPI_Section>(a, b, range);
}
