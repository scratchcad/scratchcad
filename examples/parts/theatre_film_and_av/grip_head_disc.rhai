// C-stand grip head half: 63 mm serrated disc 9 mm thick with 36 radial teeth 1.5 mm tall, 40 mm hub 32 mm long behind it, 16 mm (5/8 in) and 12.7 mm (1/2 in) cross holes through the hub, 9 mm center bolt bore
let diameter = 63.0; // [50.0, 75.0] Disc diameter (mm)
let thickness = 9.0; // [6.0, 12.0] Disc thickness (mm)
let teeth = 36; // [18, 60] Number of serration teeth
let hub = 40.0; // [34.0, 50.0] Hub diameter (mm)
let hub_length = 32.0; // [28.0, 40.0] Hub length (mm)
let bolt = 9.0; // [6.0, 12.0] Center bolt bore (mm)
let r = diameter / 2.0;
let disc = cylinder(r, thickness) + cylinder([0, 0, 0.01], "-Z", hub / 2.0, hub_length);
let serr = [];
for k in 0..teeth {
    let w = PI() * diameter / teeth.to_float() * 0.5;
    serr.push(polygon("YZ", [[-w / 2.0, thickness - 0.01], [w / 2.0, thickness - 0.01], [0, thickness + 1.5]]).to_face().extrude([r - 10.0, 0, 0]).translate([10.0, 0, 0]).rotate_z(k.to_float() * 360.0 / teeth.to_float()));
}
let hole_a = cylinder([-hub, 0, -hub_length * 0.27], "X", 8.0, hub * 2.0);
let hole_b = cylinder([0, -hub, -hub_length * 0.75], "Y", 6.35, hub * 2.0);
(disc + fuse_all(serr)) - cylinder([0, 0, -hub_length - 1.0], "Z", bolt / 2.0, hub_length + thickness + 4.0) - hole_a - hole_b
