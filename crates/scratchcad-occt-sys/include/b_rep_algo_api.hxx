// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <BRepAlgoAPI_Common.hxx>
#include <BRepAlgoAPI_Cut.hxx>
#include <BRepAlgoAPI_Fuse.hxx>
#include <BRepAlgoAPI_Section.hxx>
#include <Message_Alert.hxx>
#include <Message_Report.hxx>
#include <TopTools_ListOfShape.hxx>
#include <TopoDS_Iterator.hxx>
#include <bindings_common.hxx>

// Appends `tool` to `tools`, or a compound's children (and theirs) one by one. The shapes inside
// one operand must not overlap: cutting with a compound of a hole and its counterbore as a single
// tool leaves the counterbore uncut, without an error. Separate tools may overlap freely.
inline void append_tools(const TopoDS_Shape &tool, TopTools_ListOfShape &tools) {
  if (tool.ShapeType() != TopAbs_COMPOUND) {
    tools.Append(tool);
    return;
  }
  for (TopoDS_Iterator it(tool); it.More(); it.Next()) {
    append_tools(it.Value(), tools);
  }
}

// Runs a boolean operation in OpenCASCADE's "safe processing mode", which never modifies the
// arguments (by default the operation may, for example, raise the tolerances of their
// sub-shapes). The operation stops early when `range` asks it to. Returns null if it fails.
// `warnings` gets the names of the warnings OpenCASCADE raised, separated by commas (such as
// "BOPAlgo_AlertAcquiredSelfIntersection"): a healthy boolean raises none, so they are the cue to
// check the result.
template <typename Operation>
std::unique_ptr<TopoDS_Shape> run_boolean(const TopoDS_Shape &argument, const TopTools_ListOfShape &tools,
                                          const Message_ProgressRange &range, rust::String &warnings) {
  TopTools_ListOfShape arguments;
  arguments.Append(argument);
  Operation operation;
  operation.SetArguments(arguments);
  operation.SetTools(tools);
  operation.SetNonDestructive(Standard_True);
  operation.Build(range);
  std::string names;
  const Message_ListOfAlert &alerts = operation.GetReport()->GetAlerts(Message_Warning);
  for (Message_ListOfAlert::Iterator it(alerts); it.More(); it.Next()) {
    std::string name = it.Value()->GetMessageKey();
    if (("," + names + ",").find("," + name + ",") == std::string::npos) {
      names += (names.empty() ? "" : ",") + name;
    }
  }
  warnings = rust::String(names);
  if (!operation.IsDone() || operation.HasErrors()) {
    return std::unique_ptr<TopoDS_Shape>(nullptr);
  }
  return std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape(operation.Shape()));
}

template <typename Operation>
std::unique_ptr<TopoDS_Shape> run_boolean(const TopoDS_Shape &argument, const TopoDS_Shape &tool,
                                          const Message_ProgressRange &range, rust::String &warnings) {
  TopTools_ListOfShape tools;
  append_tools(tool, tools);
  if (tools.IsEmpty()) {
    tools.Append(tool);
  }
  return run_boolean<Operation>(argument, tools, range, warnings);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_fuse(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                      const Message_ProgressRange &range, rust::String &warnings) {
  return run_boolean<BRepAlgoAPI_Fuse>(a, b, range, warnings);
}

// Fuses `argument` with every child of the compound `tools` in one operation, which is much faster
// than fusing them one at a time: each pairwise fuse intersects the growing result again.
inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_fuse_children(const TopoDS_Shape &argument, const TopoDS_Shape &tools,
                                                               const Message_ProgressRange &range,
                                                               rust::String &warnings) {
  TopTools_ListOfShape list;
  append_tools(tools, list);
  return run_boolean<BRepAlgoAPI_Fuse>(argument, list, range, warnings);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_cut(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                     const Message_ProgressRange &range, rust::String &warnings) {
  return run_boolean<BRepAlgoAPI_Cut>(a, b, range, warnings);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_common(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                        const Message_ProgressRange &range, rust::String &warnings) {
  return run_boolean<BRepAlgoAPI_Common>(a, b, range, warnings);
}

inline std::unique_ptr<TopoDS_Shape> BRepAlgoAPI_section(const TopoDS_Shape &a, const TopoDS_Shape &b,
                                                         const Message_ProgressRange &range, rust::String &warnings) {
  return run_boolean<BRepAlgoAPI_Section>(a, b, range, warnings);
}
