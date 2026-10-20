// Rubber bath plug for a 38 mm waste: 40 mm top tapering to 35 mm, 15 mm tall, two sealing ribs, 20 mm chain ring on top
let top_diameter = 40.0; // [30.0, 55.0] Top diameter (mm)
let bottom_diameter = 35.0; // [25.0, 50.0] Bottom diameter (mm)
let height = 15.0; // [10.0, 25.0] Plug height (mm)
let ring_diameter = 20.0; // [12.0, 30.0] Chain ring diameter (mm)
let rt = top_diameter / 2.0;
let rb = min(bottom_diameter / 2.0, rt - 0.5);
let plug = cone(rb, rt, height).fillet(1.0, ">Z or <Z");
for i in 0..2 {
    let z = height * (0.3 + 0.3 * i.to_float());
    plug += torus(rb + (rt - rb) * z / height, 0.6).translate([0, 0, z]);
}
plug -= sphere([0, 0, -rt * 1.2 + 4.0], rt * 1.2) & cylinder([0, 0, -1.0], "Z", rb - 2.0, 6.0);
let rr = ring_diameter / 2.0;
let boss = cylinder([0, 0, height - 0.5], "Z", 6.0, 4.0).fillet(1.5, ">Z");
let ring = torus(rr, 1.5).rotate_x(90.0).translate([0, 0, height + 2.0 + rr]);
fuse_all([plug, boss, ring])
