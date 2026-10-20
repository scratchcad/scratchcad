// Honey dipper: 150 mm turned stick, 32 mm long grooved head 26 mm across with six 2.5 mm grooves, 9 mm shaft, 14 mm knob end
let length = 150.0; // [100.0, 220.0] Overall length (mm)
let head_length = 32.0; // [20.0, 50.0] Head length (mm)
let head_diameter = 26.0; // [16.0, 36.0] Head diameter (mm)
let groove_count = 6; // [3, 10] Number of grooves
let shaft_diameter = 9.0; // [6.0, 12.0] Shaft diameter (mm)
let rh = head_diameter / 2.0;
let rs = shaft_diameter / 2.0;
let p = sketch("XZ").move_to(0, 0).hline_to(rh * 0.6).arc_to(rh * 0.95, 3.0, rh, 8.0).vline_to(head_length - 6.0).arc_to(rh * 0.8, head_length - 1.0, rs, head_length + 4.0)
    .vline_to(length - 14.0).arc_to(7.0, length - 7.0, rs, length - 2.0).arc_to(2.0, length - 0.2, 0, length).close();
let dipper = p.to_face().revolve("Z", 360);
let pitch = (head_length - 14.0) / (groove_count - 1).max(1).to_float();
let grooves = [];
for i in 0..groove_count {
    grooves.push(torus(rh + 0.6, 2.0).translate([0, 0, 8.0 + i.to_float() * pitch]));
}
dipper - fuse_all(grooves)
