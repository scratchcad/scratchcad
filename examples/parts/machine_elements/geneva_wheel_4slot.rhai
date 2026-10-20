// Geneva drive driven wheel, 4 slots, 50 mm centre distance: 70.7 mm diameter, 6.2 mm slots 20.7 mm deep for a 6 mm pin, 26.6 mm locking arcs, 8 mm thick, 10 mm bore
let centre_distance = 50.0; // [30.0, 120.0] Centre distance to the driver (mm)
let pin_diameter = 6.0; // [3.0, 12.0] Drive pin diameter (mm)
let thickness = 8.0; // [3.0, 20.0] Wheel thickness (mm)
let bore = 10.0; // [4.0, 20.0] Bore diameter (mm)
const slots = 4;
let half = PI() / slots.to_float();
let rw = centre_distance * half.cos();
let crank = centre_distance * half.sin();
let slot_inner = rw + crank - centre_distance - 1.0;
let sw = pin_diameter + 0.2;
let lock_r = crank - pin_diameter * 1.5;
let wheel = cylinder(rw, thickness);
let tools = [];
for i in 0..slots {
    let a = i.to_float() * 360.0 / slots.to_float();
    let s = box_from_corners([rw - slot_inner, -sw / 2.0, -1], [rw + 1.0, sw / 2.0, thickness + 1.0]) + cylinder([rw - slot_inner, 0, -1], "Z", sw / 2.0, thickness + 2.0);
    tools.push(s.rotate("Z", a));
    tools.push(cylinder([centre_distance, 0, -1], "Z", lock_r + 0.25, thickness + 2.0).rotate("Z", a + 180.0 / slots.to_float()));
}
wheel = wheel - fuse_all(tools);
wheel = wheel - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0);
print(`wheel diameter ${2.0 * rw}, slot depth ${rw - (rw - slot_inner)}`);
wheel.chamfer(0.3, "%CIRCLE and >Z and not %LINE")
