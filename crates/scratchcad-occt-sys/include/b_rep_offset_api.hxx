#include <Approx_ParametrizationType.hxx>
#include <BRepOffsetAPI_MakeOffset.hxx>
#include <BRepOffsetAPI_MakePipe.hxx>
#include <BRepOffsetAPI_MakePipeShell.hxx>
#include <BRepOffsetAPI_MakeThickSolid.hxx>
#include <BRepOffsetAPI_ThruSections.hxx>
#include <Law_Function.hxx>
#include <TopTools_ListOfShape.hxx>
#include <TopoDS_Shape.hxx>
#include <bindings_common.hxx>
#include <gp_Dir.hxx>

// Joins the pieces of a path with sharp corners with mitred corners, rather than leaving gaps.
inline void BRepOffsetAPI_MakePipeShell_SetRightCorners(BRepOffsetAPI_MakePipeShell &make) {
  make.SetTransitionMode(BRepBuilderAPI_RightCorner);
}
