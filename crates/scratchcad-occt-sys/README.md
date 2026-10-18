# scratchcad-occt-sys

Low-level [cxx](https://cxx.rs) bindings to OpenCASCADE 7.8, used by `scratchcad-occt-rhai`.

* **C++ exceptions become `Result`s.** A custom `rust::behavior::trycatch` in
  `include/bindings_common.hxx` translates OCCT's `Standard_Failure` (and `std::exception`) into
  `cxx::Exception` with the message `"<exception type>: <message>"`, and every binding that can
  throw returns `Result`, instead of the OCCT exception aborting the process.
* **Explicit checks where OCCT's are compiled out.** OCCT's release build defines `No_Exception`,
  disabling the `*_Raise_if` checks inside its libraries; helpers whose OCCT calls would otherwise
  return null handles or crash check explicitly and throw. Handle dereferences throw
  `Standard_NullObject` instead of dereferencing null.
* **One module per OCCT package**, named in snake case (`BRepPrimAPI` -> `b_rep_prim_api`).
* **Cancellation and console output go through Rust.** `message::Message_CancellableProgress`
  is a progress indicator whose `UserBreak()` reads a Rust `CancelFlag`, so algorithms given its
  range stop when the flag is set from any thread. `Message_use_rust_printer` replaces OCCT's
  stdout printer with one that forwards messages to a Rust handler.

By default an installed OpenCASCADE 7.8 is located with CMake (set `DEP_OCCT_ROOT` to its prefix
if it is not in a standard location; conda-forge's `occt=7.8.1` works). With the `builtin`
feature, OpenCASCADE is compiled from source by the unmodified
[`occt-sys`](https://crates.io/crates/occt-sys) crate instead.
