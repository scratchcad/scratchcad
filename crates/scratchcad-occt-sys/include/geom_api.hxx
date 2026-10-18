// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <GeomAPI_Interpolate.hxx>
#include <GeomAPI_ProjectPointOnSurf.hxx>
#include <Geom_BSplineCurve.hxx>
#include <StdFail_NotDone.hxx>
#include <bindings_common.hxx>

inline std::unique_ptr<Handle_Geom_BSplineCurve> GeomAPI_Interpolate_Curve(const GeomAPI_Interpolate &interpolate) {
  return std::unique_ptr<Handle_Geom_BSplineCurve>(new opencascade::handle<Geom_BSplineCurve>(interpolate.Curve()));
}

// The method's own StdFail_NotDone check is compiled out of OCCT's release build (-DNo_Exception).
inline void GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(const GeomAPI_ProjectPointOnSurf &projector,
                                                               Standard_Real &u, Standard_Real &v) {
  if (!projector.IsDone() || projector.NbPoints() < 1) {
    throw StdFail_NotDone("GeomAPI_ProjectPointOnSurf: no projection found");
  }
  projector.LowerDistanceParameters(u, v);
}
