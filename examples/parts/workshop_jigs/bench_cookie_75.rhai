// Bench cookie work support: 75 mm x 22 mm puck, 3 concentric 1.5 mm grip grooves on each face, 6 mm centre hole, 1 mm edge chamfers
let diameter = 75.0; // [50.0, 100.0] Puck diameter (mm)
let height = 22.0; // [15.0, 30.0] Puck height (mm)
let groove_w = 1.5; // [1.0, 3.0] Groove width (mm)
let hole_d = 6.0; // [0.0, 10.0] Centre hole (mm)
let r = diameter / 2.0;
let puck = cylinder(r, height);
let p = puck.chamfer(1.0);
let grooves = [];
for i in 1..4 {
    let rr = r * i.to_float() / 4.0;
    for z in [-1.0, height - 1.0] { grooves.push(cylinder([0, 0, z], "Z", rr + groove_w / 2.0, 2.0) - cylinder([0, 0, z - 1.0], "Z", rr - groove_w / 2.0, 4.0)); }
}
let res = p - compound(grooves);
if hole_d > 0.5 { res - cylinder([0, 0, -1], "Z", hole_d / 2.0, height + 2.0) } else { res }
