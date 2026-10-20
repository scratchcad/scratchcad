// 65 mm robot wheel for yellow TT gear motors: 26 mm wide rubber tire with 24 tread grooves on a 5-spoke rim, 5.4 mm D-shaft bore with 3.7 mm flats, 2 mm M2 screw hole in the hub
let wheel_d = 65.0; // [40.0, 100.0] Tire outside diameter (mm)
let width = 26.0; // [10.0, 40.0] Tire width (mm)
let tread = 24; // [0, 48] Number of tread grooves
let spokes = 5; // [3, 8] Number of spokes
const shaft = 5.4;
const flats = 3.7;
let ro = wheel_d / 2.0;
let rim_r = ro - 7.0;
let tire = (cylinder(ro, width).fillet(3.0, ">Z or <Z") - cylinder([0, 0, -1], "Z", rim_r, width + 2.0));
let g = [];
for i in 0..tread { g.push(box_centered(2.0, 4.0, width + 2.0).translate([ro, 0, width / 2.0]).rotate_z(i.to_float() * 360.0 / tread.to_float())); }
if tread > 0 { tire -= fuse_all(g); }
let rim = cylinder(rim_r + 0.01, width) - cylinder([0, 0, -1], "Z", rim_r - 2.5, width + 2.0);
let hub = cylinder([0, 0, width / 2.0 - 6.0], "Z", 6.0, 12.0);
let sp = [];
for i in 0..spokes { sp.push(box_from_corners([0, -2.5, width / 2.0 - 3.0], [rim_r - 1.0, 2.5, width / 2.0 + 3.0]).rotate_z(i.to_float() * 360.0 / spokes.to_float())); }
let wheel_body = fuse_all([rim, hub] + sp);
let bore = cylinder([0, 0, -1], "Z", shaft / 2.0, width + 2.0) & box_centered(flats, shaft + 1.0, width * 3.0);
wheel_body = wheel_body - bore - cylinder([0, 0, width / 2.0 + 3.0], "X", 1.0, 10.0);
compound([wheel_body, tire])
