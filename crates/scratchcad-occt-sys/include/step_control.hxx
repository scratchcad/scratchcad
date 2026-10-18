#include <STEPControl_Reader.hxx>
#include <STEPControl_Writer.hxx>
#include <bindings_common.hxx>
#include <cstdint>
#include <sstream>
#include <string>

inline IFSelect_ReturnStatus read_step(STEPControl_Reader &reader, rust::String theFileName) {
  return reader.ReadFile(theFileName.c_str());
}

inline std::unique_ptr<TopoDS_Shape> one_shape_step(const STEPControl_Reader &reader) {
  return std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape(reader.OneShape()));
}

inline IFSelect_ReturnStatus read_step_bytes(STEPControl_Reader &reader, rust::Slice<const std::uint8_t> bytes) {
  std::istringstream stream(std::string(reinterpret_cast<const char *>(bytes.data()), bytes.size()));
  return reader.ReadStream("memory", stream);
}

inline IFSelect_ReturnStatus transfer_shape(STEPControl_Writer &writer, const TopoDS_Shape &theShape) {
  return writer.Transfer(theShape, STEPControl_AsIs);
}

inline IFSelect_ReturnStatus transfer_shape_with_progress(STEPControl_Writer &writer, const TopoDS_Shape &theShape,
                                                          const Message_ProgressRange &range) {
  return writer.Transfer(theShape, STEPControl_AsIs, Standard_True, range);
}

// Writes the transferred model to memory. Returns null if writing fails.
inline std::unique_ptr<std::string> write_step_bytes(STEPControl_Writer &writer) {
  std::ostringstream stream;
  if (writer.WriteStream(stream) != IFSelect_RetDone) {
    return std::unique_ptr<std::string>(nullptr);
  }
  return std::unique_ptr<std::string>(new std::string(stream.str()));
}

inline IFSelect_ReturnStatus write_step(STEPControl_Writer &writer, rust::String theFileName) {
  return writer.Write(theFileName.c_str());
}
