// GT2 6 mm belt clamp plate: 20 x 12 x 5 mm with a toothed channel 6.5 mm wide and two M3 holes 14 mm apart
let length = 20.0; // [14.0, 40.0] Length (mm)
let width = 12.0; // [9.0, 20.0] Width (mm)
let thickness = 5.0; // [3.0, 10.0] Thickness (mm)
let channel_w = 6.5; // [6.2, 10.0] Belt channel width (mm)
let hole_spacing = 14.0; // [10.0, 30.0] Hole spacing (mm)
let plate = box_centered(width, length, thickness).translate([0, 0, thickness / 2.0]).fillet(1.5, "|Z");
let channel = box_centered(channel_w, length + 2.0, 1.4).translate([0, 0, thickness - 0.7]);
let teeth = [];
let n = (length / 2.0).to_int();
for i in 0..n { teeth.push(box_centered(channel_w, 1.0, 0.8).translate([0, -length / 2.0 + 1.0 + i.to_float() * 2.0, thickness - 1.4 + 0.4])); }
plate = plate - channel + fuse_all(teeth);
for s in [-1, 1] { plate -= cylinder([s * hole_spacing / 2.0, 0, -1], "Z", 1.6, thickness + 2.0).rotate_z(90); }
plate
