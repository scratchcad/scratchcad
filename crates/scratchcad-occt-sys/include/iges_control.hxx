#include <IGESControl_Reader.hxx>
#include <IGESControl_Writer.hxx>
#include <TopoDS_Shape.hxx>
#include <bindings_common.hxx>
#include <sstream>
#include <string>

inline IFSelect_ReturnStatus read_iges(IGESControl_Reader &reader, rust::String theFileName) {
  return reader.ReadFile(theFileName.c_str());
}

inline std::unique_ptr<TopoDS_Shape> one_shape_iges(const IGESControl_Reader &reader) {
  return std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape(reader.OneShape()));
}

inline bool write_iges(IGESControl_Writer &writer, rust::String theFileName) {
  return writer.Write(theFileName.c_str());
}

// Writes the computed model to memory. Returns null if writing fails.
inline std::unique_ptr<std::string> write_iges_bytes(IGESControl_Writer &writer) {
  std::ostringstream stream;
  if (!writer.Write(stream)) {
    return std::unique_ptr<std::string>(nullptr);
  }
  return std::unique_ptr<std::string>(new std::string(stream.str()));
}
