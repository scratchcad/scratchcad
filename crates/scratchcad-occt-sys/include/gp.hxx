// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <bindings_common.hxx>
#include <gp.hxx>
#include <gp_Ax2.hxx>
#include <gp_Ax2d.hxx>
#include <gp_Ax3.hxx>
#include <gp_Circ.hxx>
#include <gp_Dir2d.hxx>
#include <gp_GTrsf.hxx>
#include <gp_Lin.hxx>
#include <gp_Pnt.hxx>
#include <gp_Pnt2d.hxx>
#include <gp_Trsf.hxx>
#include <gp_Vec.hxx>

inline std::unique_ptr<gp_Dir> gp_Ax2_x_direction(const gp_Ax2 &axis) {
  return std::unique_ptr<gp_Dir>(new gp_Dir(axis.XDirection()));
}

inline std::unique_ptr<gp_Dir> gp_Ax2_y_direction(const gp_Ax2 &axis) {
  return std::unique_ptr<gp_Dir>(new gp_Dir(axis.YDirection()));
}
