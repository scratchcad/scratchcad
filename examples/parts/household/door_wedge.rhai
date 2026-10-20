// Door stop wedge: 120 mm long, 40 mm wide, 25 mm tall, grip ridges on top, hanging hole
let length = 120.0; // [60.0, 200.0] Length (mm)
let width = 40.0; // [25.0, 80.0] Width (mm)
let height = 25.0; // [10.0, 50.0] Height (mm)
let ridges = 6; // [0, 12] Grip ridges
let wedge = polygon("XZ", [[0, 0], [length, 0], [length, height], [length - 15.0, height]]).to_face().extrude([0, width, 0]);
let cuts = [];
for i in 0..ridges { cuts.push(box_from_corners([length * 0.25 + i.to_float() * 10.0, -1, 0], [length * 0.25 + i.to_float() * 10.0 + 2.0, width + 1, height * 2.0])); }
let w = if ridges > 0 { wedge - (fuse_all(cuts) & polygon("XZ", [[0, 1.2], [length, height + 1.2], [length, height * 3], [0, height * 3]]).to_face().extrude([0, width + 4, 0]).translate([0, -2, 0])) } else { wedge };
w - cylinder([length - 8.0, width / 2.0, -1], "Z", 3.0, height + 2.0)
