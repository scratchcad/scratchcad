// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

//! Low-level [cxx](https://cxx.rs) bindings to the OpenCASCADE CAD kernel.
//!
//! Every binding that can throw a C++ exception returns `Result<T, cxx::Exception>`.
//! OpenCASCADE's `Standard_Failure` hierarchy (which does not derive from `std::exception`) is
//! translated by a custom `rust::behavior::trycatch` in `include/bindings_common.hxx`; the error
//! message is `"<exception type>: <message>"`. Without this, any OCCT error would abort the whole
//! process.
//!
//! Module names mirror OCCT package names in snake case (`BRepPrimAPI` -> [`b_rep_prim_api`]).

pub mod b_rep;
pub mod b_rep_adaptor;
pub mod b_rep_algo_api;
pub mod b_rep_bnd_lib;
pub mod b_rep_builder_api;
pub mod b_rep_check;
pub mod b_rep_class3d;
pub mod b_rep_extrema;
pub mod b_rep_feat;
pub mod b_rep_fill;
pub mod b_rep_fillet_api;
pub mod b_rep_g_prop;
pub mod b_rep_int_curve_surface;
pub mod b_rep_lib;
pub mod b_rep_mesh;
pub mod b_rep_offset_api;
pub mod b_rep_prim_api;
pub mod b_rep_tools;
pub mod bin_tools;
pub mod bnd;
pub mod bop_algo;
pub mod g_prop;
pub mod gc;
pub mod gc_pnts;
pub mod geom;
pub mod geom2d;
pub mod geom_abs;
pub mod geom_api;
pub mod gp;
pub mod if_select;
pub mod iges_control;
pub mod law;
pub mod message;
pub mod poly;
pub mod shape_analysis;
pub mod shape_upgrade;
pub mod standard;
pub mod step_control;
pub mod stl_api;
pub mod t_col_gp;
pub mod top_abs;
pub mod top_exp;
pub mod top_loc;
pub mod top_tools;
pub mod topo_ds;
