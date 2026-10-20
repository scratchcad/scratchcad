// Thorlabs TR3 optical post: 12.7 mm (1/2 in) diameter, 76.2 mm (3 in) long, 8-32 tapped top hole and 1/4-20 tapped bottom hole, both 6.4 mm deep
let length = 76.2; // [20.0, 150.0] Post length (mm)
let diameter = 12.7; // [10.0, 25.4] Post diameter (mm)
let hole_depth = 6.4; // [4.0, 10.0] Tapped hole depth (mm)
let tan30 = (30.0 * PI() / 180.0).tan();
fn internal_thread(r_major, pitch, depth, tan30) {
    let r_minor = r_major - 0.541 * pitch;
    let w = pitch / 16.0 + (r_major + 0.05 - (r_minor - 0.05)) * tan30;
    let section = polygon([[r_minor - 0.5, 0, -w], [r_minor - 0.05, 0, -w], [r_major + 0.05, 0, -pitch / 16.0],
                           [r_major + 0.05, 0, pitch / 16.0], [r_minor - 0.05, 0, w], [r_minor - 0.5, 0, w]]);
    let turns = (depth / pitch).floor().to_int();
    let sections = [];
    for i in 0..=(turns * 12) {
        let t = i.to_float() / 12.0;
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    let tip = cone(r_minor, 0.0, r_minor * 0.6).translate([0, 0, depth - 0.01]);
    cylinder([0, 0, -1.0], "Z", r_minor, depth + 1.0) + loft(sections, true).translate([0, 0, -pitch]) + tip
}
let post = cylinder(diameter / 2.0, length).chamfer(0.5, "%CIRCLE");
let bottom_hole = internal_thread(3.175, 1.27, hole_depth, tan30);
let top_hole = internal_thread(2.083, 0.794, hole_depth, tan30).mirror("XY").translate([0, 0, length]);
post - compound([bottom_hole, top_hole])
