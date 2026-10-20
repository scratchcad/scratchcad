// French barrette base, 60 mm: 9 mm wide, 0.8 mm thick strip arched on a 50 mm radius, hinge tube for the 1.2 mm pin at one end, catch hook at the other, three decorative slots
let length = 60.0; // [40.0, 90.0] Length (mm)
let width = 9.0; // [6.0, 14.0] Width (mm)
let thickness = 0.8; // [0.5, 1.5] Thickness (mm)
let arch_radius = 50.0; // [30.0, 120.0] Arch radius (mm)
let pin_diameter = 1.2; // [0.8, 1.6] Hinge pin diameter (mm)
let half = (length / 2.0) / arch_radius;
let deg = min(half * 180.0 / PI(), 60.0);
let section = polygon([[0, -width / 2.0, arch_radius], [0, width / 2.0, arch_radius], [0, width / 2.0, arch_radius + thickness], [0, -width / 2.0, arch_radius + thickness]]);
let strip = section.to_face().revolve([0, 0, 0], "Y", 2.0 * deg).rotate_y(-deg);
let zc = arch_radius * (deg * PI() / 180.0).cos();
strip = strip.translate([0, 0, -zc]);
let xe = arch_radius * (deg * PI() / 180.0).sin();
// slots along the crown
let slots = [];
for i in -1..=1 {
    let x = i.to_float() * length / 5.0;
    slots.push(face(rect(length / 8.0, 0.01).offset(1.0)).extrude([0, 0, 20.0]).translate([x, 0, -10.0]));
}
strip = strip - compound(slots);
// hinge tube under the -X end, catch hook under the +X end
// underside height of the strip at x, to hang the hinge and the catch from it
let rt = pin_diameter / 2.0 + 0.6;
let xh = -xe + rt;
let zh = (arch_radius * arch_radius - xh * xh).sqrt() - zc;
let xc = xe - 2.0;
let zcatch = (arch_radius * arch_radius - xc * xc).sqrt() - zc;
let hinge = cylinder([xh, -width / 2.0 + 1.0, zh - rt + 0.3], "Y", rt, width - 2.0) - cylinder([xh, -width, zh - rt + 0.3], "Y", pin_diameter / 2.0, 2.0 * width);
let catch_hook = box_from_corners([xe - 3.0, -1.5, zcatch - 3.0], [xe - 2.0, 1.5, zcatch + 0.3]) + box_from_corners([xe - 4.5, -1.5, zcatch - 3.0], [xe - 2.0, 1.5, zcatch - 2.2]);
fuse_all([strip, hinge, catch_hook])
