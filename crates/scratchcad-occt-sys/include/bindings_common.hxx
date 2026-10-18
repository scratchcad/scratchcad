// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#pragma once
#include "rust/cxx.h"
#include <NCollection_List.hxx>
#include <Standard_Failure.hxx>
#include <Standard_NullObject.hxx>
#include <Standard_Type.hxx>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

// Exception translation.
//
// cxx turns a C++ exception thrown from a function declared as returning `Result<T>` into an
// `Err(cxx::Exception)`, but by default it only knows about `std::exception`. OpenCASCADE throws
// subclasses of `Standard_Failure`, which do *not* derive from `std::exception`, so without this
// override every OCCT error would escape through the FFI boundary and abort the process.
//
// cxx detects this overload and uses it in place of its default (see
// https://cxx.rs/binding/result.html#returning-result-from-c-to-rust). Every bridge header includes
// this file, so the override is visible to all generated shims.
//
// The resulting message has the form `<OCCT exception type>: <message>`, e.g.
// `Standard_ConstructionError: gp_Dir() - input vector has zero norm`.
namespace rust {
namespace behavior {

template <typename Try, typename Fail> static void trycatch(Try &&func, Fail &&fail) noexcept try {
  func();
} catch (const Standard_Failure &e) {
  std::string message = e.DynamicType()->Name();
  const char *detail = e.GetMessageString();
  if (detail != nullptr && detail[0] != '\0') {
    message += ": ";
    message += detail;
  }
  fail(message.c_str());
} catch (const std::exception &e) {
  fail(e.what());
} catch (...) {
  fail("unknown C++ exception");
}

} // namespace behavior
} // namespace rust

// Generic template constructor
template <typename T, typename... Args> std::unique_ptr<T> construct_unique(Args... args) {
  return std::unique_ptr<T>(new T(args...));
}

// Type casting
template <typename T, typename U> inline U upcast(T src) { return src; }
template <typename T, typename U> inline const U &upcast_ref(const T &src) { return src; }

// Generic List
template <typename T> std::unique_ptr<std::vector<T>> list_to_vector(const NCollection_List<T> &list) {
  return std::unique_ptr<std::vector<T>>(new std::vector<T>(list.begin(), list.end()));
}

// Throws `Standard_NullObject` instead of dereferencing a null handle (which would be undefined
// behavior). Used by every helper below that dereferences a handle received from Rust.
template <typename T> const opencascade::handle<T> &check_handle(const opencascade::handle<T> &handle) {
  if (handle.IsNull()) {
    throw Standard_NullObject("null handle dereference");
  }
  return handle;
}

template <typename T> const T &handle_try_deref(const opencascade::handle<T> &handle) { return *check_handle(handle); }
