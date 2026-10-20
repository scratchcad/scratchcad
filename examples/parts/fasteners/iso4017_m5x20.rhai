// ISO 4017 M5 x 20 hex head bolt, fully threaded (thread shown as plain shank): 8 mm AF, 3.5 mm head
let diameter = 5.0; // [3.0, 12.0] Thread diameter (mm)
let length = 20.0; // [6.0, 60.0] Length under head (mm)
let across_flats = 8.0; // [5.5, 19.0] Width across flats (mm)
let head_h = 3.5; // [2.0, 8.0] Head height (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(pts).to_face().extrude(head_h).chamfer(0.4, ">Z");
let shank = cylinder([0, 0, -length], "Z", diameter / 2.0, length + 0.1).chamfer(0.5, "<Z");
head + shank
