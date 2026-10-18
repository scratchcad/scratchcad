// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#include <Standard_Type.hxx>
#include <bindings_common.hxx>

inline rust::String type_name(const Handle_Standard_Type &handle) { return std::string(check_handle(handle)->Name()); }
