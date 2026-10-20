// 120 mm PC case fan
let size = 120.0; // [80.0, 140.0] Frame size (mm)
let depth = 25.0; // [15.0, 38.0] Frame depth (mm)
let hole_spacing = 105.0; // [71.5, 124.5] Mounting hole spacing (mm)
let hole_d = 4.3; // [3.5, 5.0] Mounting hole diameter (mm)
let blades = 7; // [3, 11] Number of blades
let hub_d = 40.0; // [25.0, 50.0] Hub diameter (mm)
let duct_d = size - 4.0;
let frame = box_centered(size, size, depth).translate([0, 0, depth / 2.0]).fillet(4.0, "|Z");
frame -= cylinder([0, 0, -1], "Z", duct_d / 2.0, depth + 2.0);
// leave thin corner flanges: pocket the corners between the front and back plates
for sx in [-1, 1] { for sy in [-1, 1] {
    frame -= cylinder([sx * hole_spacing / 2.0, sy * hole_spacing / 2.0, -1], "Z", hole_d / 2.0, depth + 2.0);
} }
let hub = cylinder([0, 0, 3.0], "Z", hub_d / 2.0, depth - 4.0);
let struts = [];
for i in 0..4 { struts.push(box_from_corners([hub_d / 2.0 - 1.0, -1.5, 0.0], [duct_d / 2.0 + 1.0, 1.5, 3.0]).rotate_z(45 + i * 90)); }
// blades: lofted, twisted plates from the hub to near the duct
let r_in = hub_d / 2.0 - 1.0; let r_out = duct_d / 2.0 - 1.5;
let chord_in = 22.0; let chord_out = 34.0;
fn blade_section(r, chord, twist, z0, depth) {
    let t = 1.2;
    polygon([[-chord / 2.0, -t / 2.0], [chord / 2.0, -t / 2.0], [chord / 2.0, t / 2.0], [-chord / 2.0, t / 2.0]])
        .rotate_x(90).rotate_y(0).rotate([0, 0, 0], "X", 0).rotate("Y", twist).rotate_z(90).translate([r, 0, z0 + depth / 2.0])
}
let one = loft([blade_section(r_in, chord_in, 55.0, 0.0, depth), blade_section(r_out, chord_out, 30.0, 0.0, depth)], true);
let all_blades = [];
for i in 0..blades { all_blades.push(one.rotate_z(i * 360.0 / blades.to_float())); }
let rotor = fuse_all([hub] + all_blades) & cylinder([0, 0, 2.5], "Z", r_out, depth - 3.0);
fuse_all([frame] + struts + [rotor])
