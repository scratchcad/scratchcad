// Flanged lead screw nut for T8 (8 mm, 2 mm pitch, 4 starts) screws: 10.2 mm body 15 mm long, 22 mm flange 3.5 mm thick, four 3.5 mm holes on a 16 mm circle, 8 mm bore with 0.5 mm chamfers
let screw_diameter = 8.0; // [5.0, 16.0] Screw diameter (mm)
let body_diameter = 10.2; // [7.0, 24.0] Body diameter (mm)
let flange_diameter = 22.0; // [14.0, 48.0] Flange diameter (mm)
let flange_thickness = 3.5; // [2.0, 8.0] Flange thickness (mm)
let length = 15.0; // [8.0, 40.0] Overall length (mm)
let hole_circle = 16.0; // [10.0, 40.0] Mounting hole circle (mm)
const holes = 4;
const hole_d = 3.5;
let rb = max(body_diameter / 2.0, screw_diameter / 2.0 + 1.0);
let rf = max(flange_diameter / 2.0, rb + hole_d + 1.5);
let hc = min(max(hole_circle / 2.0, rb + hole_d / 2.0 + 0.3), rf - hole_d / 2.0 - 0.6);
let nut = cylinder(rf, flange_thickness) + cylinder([0, 0, flange_thickness - 0.01], "Z", rb, length - flange_thickness + 0.01);
let tools = [];
for i in 0..holes {
    let a = i.to_float() * 2.0 * PI() / holes.to_float();
    tools.push(cylinder([hc * a.cos(), hc * a.sin(), -1], "Z", hole_d / 2.0, flange_thickness + 2.0));
}
nut = nut - compound(tools);
nut = nut - cylinder([0, 0, -1], "Z", screw_diameter * 0.75 / 2.0, length + 2.0);
nut.chamfer(0.5, "%CIRCLE and (>Z or <Z)")
