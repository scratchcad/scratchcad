// GT2 20-tooth timing pulley, 6 mm belt, 5 mm bore
// # Teeth
let teeth = 20; // [12, 60] Number of teeth
let belt_width = 7.0; // [6.0, 11.0] Toothed width (mm)
// # Body
let flange_d = 16.0; // [12.0, 40.0] Flange diameter (mm)
let flange_t = 1.0; // [0.8, 2.0] Flange thickness (mm)
let hub_d = 16.0; // [10.0, 30.0] Hub diameter (mm)
let hub_length = 7.0; // [4.0, 12.0] Hub length (mm)
let bore = 5.0; // [3.0, 8.0] Bore (mm)
const pitch = 2.0;
let pd = teeth.to_float() * pitch / PI();       // pitch diameter
let od = pd - 0.508;                            // tip diameter (pitch line offset 0.254 mm)
const groove_r = 0.555;                           // GT2 groove radius
// teeth: a cylinder at the tip diameter with round grooves cut between the teeth
let toothed = cylinder([0, 0, hub_length + flange_t - 0.01], "Z", od / 2.0, belt_width + 0.02);
let grooves = [];
for i in 0..teeth {
    let a = i.to_float() * 360.0 / teeth.to_float();
    grooves.push(cylinder([od / 2.0 - 0.2, 0, hub_length], "Z", groove_r, belt_width + 2.0 * flange_t + 1.0).rotate_z(a));
}
toothed = toothed - fuse_all(grooves);
let hub = cylinder(hub_d / 2.0, hub_length);
let f1 = cylinder([0, 0, hub_length], "Z", flange_d / 2.0, flange_t);
let f2 = cylinder([0, 0, hub_length + flange_t + belt_width], "Z", flange_d / 2.0, flange_t);
let total = hub_length + 2.0 * flange_t + belt_width;
let body = fuse_all([hub, f1, toothed, f2]);
body = body - cylinder([0, 0, -1], "Z", bore / 2.0, total + 2.0);
// two M3 set screws at 90 degrees, in the hub
for a in [0, 90] {
    body -= cylinder([0, 0, hub_length / 2.0], "X", 1.25, hub_d).rotate_z(a);
}
body.chamfer(0.3, "%CIRCLE and >Z")
