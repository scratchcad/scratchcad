// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

#pragma once
#include <Message.hxx>
#include <Message_Gravity.hxx>
#include <Message_Messenger.hxx>
#include <Message_Printer.hxx>
#include <Message_PrinterOStream.hxx>
#include <Message_ProgressIndicator.hxx>
#include <Message_ProgressRange.hxx>
#include <TCollection_AsciiString.hxx>
#include <bindings_common.hxx>
#include <cstdint>

// Implemented in Rust (see `src/message.rs`); cxx generates their definitions.
struct CancelFlag;
bool cancel_requested(const CancelFlag &flag) noexcept;
void deliver_message(Message_Gravity gravity, rust::Slice<const std::uint8_t> text) noexcept;

inline void Message_set_default_trace_level(Message_Gravity level) {
  const Message_SequenceOfPrinters &printers = Message::DefaultMessenger()->Printers();
  for (Message_SequenceOfPrinters::Iterator it(printers); it.More(); it.Next()) {
    it.Value()->SetTraceLevel(level);
  }
}

inline Standard_Integer Message_default_printer_count() { return Message::DefaultMessenger()->Printers().Length(); }

// Forwards every message at or above its trace level to Rust's `deliver_message`.
class RustMessagePrinter : public Message_Printer {
public:
  explicit RustMessagePrinter(Message_Gravity level) { myTraceLevel = level; }

  void send(const TCollection_AsciiString &text, const Message_Gravity gravity) const override {
    // Messages may hold bytes that are not UTF-8 (file names, say); Rust decodes them lossily.
    deliver_message(gravity, rust::Slice<const std::uint8_t>(reinterpret_cast<const std::uint8_t *>(text.ToCString()),
                                                             static_cast<std::size_t>(text.Length())));
  }
};

// Replaces every printer of the default messenger with one that forwards to Rust.
inline void Message_use_rust_printer(Message_Gravity level) {
  const Handle(Message_Messenger) &messenger = Message::DefaultMessenger();
  messenger->ChangePrinters().Clear();
  messenger->AddPrinter(new RustMessagePrinter(level));
}

// Replaces every printer of the default messenger with one writing to stdout or stderr.
inline void Message_use_stream_printer(bool to_stderr, Message_Gravity level) {
  const Handle(Message_Messenger) &messenger = Message::DefaultMessenger();
  messenger->ChangePrinters().Clear();
  if (to_stderr) {
    messenger->AddPrinter(new Message_PrinterOStream("cerr", Standard_False, level));
  } else {
    messenger->AddPrinter(new Message_PrinterOStream(level));
  }
}

// A progress indicator whose only job is to let OpenCASCADE's algorithms ask Rust whether they
// should stop. Algorithms poll `UserBreak()` through the progress range they are given.
class RustCancelIndicator : public Message_ProgressIndicator {
public:
  explicit RustCancelIndicator(const CancelFlag &flag) : myFlag(flag) {}

  Standard_Boolean UserBreak() override { return cancel_requested(myFlag); }

  void Show(const Message_ProgressScope &, const Standard_Boolean) override {}

private:
  // Owned by Rust, which keeps it alive for as long as this indicator exists.
  const CancelFlag &myFlag;
};

// The indicator together with the root range it hands out: the range points into the indicator,
// so they must live (and die) together. The range is declared last, so it is destroyed first.
struct Message_CancellableProgress {
  Handle(Message_ProgressIndicator) indicator;
  Message_ProgressRange range;
};

inline std::unique_ptr<Message_CancellableProgress> Message_CancellableProgress_new(const CancelFlag &flag) {
  auto progress = std::unique_ptr<Message_CancellableProgress>(new Message_CancellableProgress());
  progress->indicator = new RustCancelIndicator(flag);
  progress->range = progress->indicator->Start();
  return progress;
}

inline const Message_ProgressRange &Message_CancellableProgress_range(const Message_CancellableProgress &progress) {
  return progress.range;
}
