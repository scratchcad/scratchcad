// Round drink coaster: 100 mm diameter, 5 mm thick, 1.5 mm raised rim, concentric grooves on top
let diameter = 100.0; // [70.0, 140.0] Diameter (mm)
let thickness = 5.0; // [3.0, 10.0] Thickness (mm)
let rim = 1.5; // [0.5, 4.0] Rim height (mm)
let grooves = 4; // [0, 10] Grooves
let r = diameter / 2.0;
let c = cylinder(r, thickness + rim) - cylinder([0, 0, thickness], "Z", r - 3.0, rim + 1.0);
for k in 1..=grooves {
    let gr = (r - 3.0) * k.to_float() / (grooves + 1).to_float();
    c -= cylinder([0, 0, thickness - 0.8], "Z", gr + 0.6, 1.0) - cylinder([0, 0, thickness - 1.0], "Z", gr - 0.6, 2.0);
}
c.fillet(1.0, ">Z")
