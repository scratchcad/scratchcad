// Olive oil bottle pour spout: tapered ribbed plug 17 to 21 mm over 22 mm, 7 mm bore, spout tube 10 mm OD 45 mm long angled 30 deg with a slanted drip-free tip, 2 mm air tube
let plug_length = 22.0; // [15.0, 30.0] Plug length (mm)
let tip_diameter = 17.0; // [14.0, 20.0] Plug tip diameter (mm)
let top_diameter = 21.0; // [17.0, 26.0] Plug top diameter (mm)
let spout_length = 45.0; // [20.0, 80.0] Spout length (mm)
let spout_angle = 30.0; // [0.0, 50.0] Spout tilt (deg)
let bore = 7.0; // [4.0, 8.0] Pour bore (mm)
let r0 = tip_diameter / 2.0;
let r1 = max(top_diameter / 2.0, r0 + 0.5);
let plug = cone(r0, r1, plug_length);
for z in [6.0, 12.0, 18.0] {
    plug += torus(r0 + (r1 - r0) * z / plug_length - 0.2, 0.9).translate([0, 0, z]);
}
let collar = cylinder([0, 0, plug_length - 0.1], "Z", r1 + 3.0, 4.0).fillet(1.0, "%CIRCLE");
// spout tube tilted toward +X from the collar's top centre
let top = plug_length + 3.9;
let dir = vec3((spout_angle * PI() / 180.0).sin(), 0.0, (spout_angle * PI() / 180.0).cos());
let tube = cylinder([0, 0, top - 2.0], dir, 5.0, spout_length + 2.0);
let body = fuse_all([plug, collar, tube]);
body -= cylinder([0, 0, -1.0], "Z", bore / 2.0, top + 1.0) + cylinder([0, 0, top - 2.5], dir, bore / 2.0 - 0.5, spout_length + 10.0);
// slanted tip: cut the tube end with a plane tilted 40 deg
let tip = vec3(0.0, 0.0, top - 2.0) + dir * (spout_length + 2.0);
body -= box_centered(40.0, 40.0, 40.0).translate([0, 0, 20.0]).rotate_y(spout_angle + 40.0).translate(tip - dir * 4.0);
// air tube beside the bore
body - cylinder([-r0 + 3.0, 0, -1.0], "Z", 1.0, top + 1.5)
