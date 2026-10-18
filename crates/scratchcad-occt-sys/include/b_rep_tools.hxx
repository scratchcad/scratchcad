#include <BRepTools.hxx>
#include <BRep_Builder.hxx>
#include <TopoDS_Wire.hxx>
#include <bindings_common.hxx>
#include <cstdint>
#include <sstream>
#include <string>

inline std::unique_ptr<TopoDS_Wire> outer_wire(const TopoDS_Face &face) {
  return std::unique_ptr<TopoDS_Wire>(new TopoDS_Wire(BRepTools::OuterWire(face)));
}

inline bool write_brep_text(const TopoDS_Shape &shape, rust::String path) {
  return BRepTools::Write(shape, path.c_str());
}

inline std::unique_ptr<TopoDS_Shape> read_brep_text(rust::String path) {
  BRep_Builder builder;
  auto shape = std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape());

  if (BRepTools::Read(*shape, path.c_str(), builder)) {
    return shape;
  } else {
    return std::unique_ptr<TopoDS_Shape>(nullptr);
  }
}

// The same bytes `BRepTools::Write` writes to a file, header line included.
inline std::unique_ptr<std::string> write_brep_bytes(const TopoDS_Shape &shape, const Message_ProgressRange &range) {
  std::ostringstream stream;
  // BRepTools::Write adds this line when writing a file but not a stream; add it so both match.
  stream << "DBRep_DrawableShape\n";
  BRepTools::Write(shape, stream, range);
  return std::unique_ptr<std::string>(new std::string(stream.str()));
}

// Returns null if `bytes` do not hold a BREP shape.
inline std::unique_ptr<TopoDS_Shape> read_brep_bytes(rust::Slice<const std::uint8_t> bytes,
                                                     const Message_ProgressRange &range) {
  std::istringstream stream(std::string(reinterpret_cast<const char *>(bytes.data()), bytes.size()));
  BRep_Builder builder;
  auto shape = std::unique_ptr<TopoDS_Shape>(new TopoDS_Shape());
  BRepTools::Read(*shape, stream, builder, range);
  if (shape->IsNull()) {
    return std::unique_ptr<TopoDS_Shape>(nullptr);
  }
  return shape;
}
