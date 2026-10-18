// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <BRepAdaptor_Curve.hxx>
#include <BRepAdaptor_Surface.hxx>
#include <Standard_NoSuchObject.hxx>
#include <TopoDS_Edge.hxx>
#include <TopoDS_Face.hxx>
#include <bindings_common.hxx>
#include <gp_Circ.hxx>

inline std::unique_ptr<gp_Pnt> BRepAdaptor_Curve_value(const BRepAdaptor_Curve &curve, const Standard_Real U) {
  return std::unique_ptr<gp_Pnt>(new gp_Pnt(curve.Value(U)));
}

inline std::unique_ptr<gp_Circ> BRepAdaptor_Curve_circle(const BRepAdaptor_Curve &curve) {
  // OCCT's own type check is compiled out of its release build (-DNo_Exception), and reading a
  // non-circle as a circle dereferences a null handle.
  if (curve.GetType() != GeomAbs_Circle) {
    throw Standard_NoSuchObject("BRepAdaptor_Curve::Circle - the curve is not a circle");
  }
  return std::unique_ptr<gp_Circ>(new gp_Circ(curve.Circle()));
}

inline std::unique_ptr<gp_Pnt> BRepAdaptor_Surface_value(const BRepAdaptor_Surface &surface, const Standard_Real U,
                                                         const Standard_Real V) {
  return std::unique_ptr<gp_Pnt>(new gp_Pnt(surface.Value(U, V)));
}
