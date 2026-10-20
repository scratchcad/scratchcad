// Bench planing stop: 300 x 40 x 19 mm batten with a 3 mm toothed plate projecting 4 mm along the front, 6 mm teeth, 3 countersunk 5 mm screw holes
let length = 300.0; // [150.0, 450.0] Stop length (mm)
let width = 40.0; // [25.0, 60.0] Batten width (mm)
let height = 19.0; // [12.0, 30.0] Batten height (mm)
let tooth_pitch = 6.0; // [4.0, 12.0] Tooth pitch (mm)
let projection = 4.0; // [2.0, 8.0] Tooth projection (mm)
let bar = box_from_corners([0, 0, 0], [length, width, height]);
let n = (length / tooth_pitch).floor().to_int();
let p = length / n.to_float();
let pts = [[0, width - 10.0, 0], [length, width - 10.0, 0], [length, width, 0]];
for k in 0..n {
    let i = n - 1 - k;
    pts.push([(i.to_float() + 0.5) * p, width + projection, 0]);
    pts.push([i.to_float() * p, width, 0]);
}
let plate = polygon(pts).to_face().extrude([0, 0, 3.0]).translate([0, 0, height - 3.0]);
let holes = [];
for x in [length * 0.15, length * 0.5, length * 0.85] { holes.push(cylinder([x, width * 0.4, -1], "Z", 2.5, height + 2.0) + cone(2.5, 5.0, 2.5).translate([x, width * 0.4, height - 2.49])); }
bar + plate - fuse_all(holes)
