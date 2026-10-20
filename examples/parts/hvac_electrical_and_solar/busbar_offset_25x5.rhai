// Copper busbar 25 x 5 mm with a 20 mm joggle (offset bend), 200 mm long, 5 mm inner bend radius, four 9 mm holes for M8 bolts
let width = 25.0; // [12.0, 60.0] Bar width (mm)
let t = 5.0; // [2.0, 10.0] Bar thickness (mm)
let length = 200.0; // [120.0, 400.0] Overall length (mm)
let offset = 20.0; // [8.0, 50.0] Joggle offset (mm)
let hole_d = 9.0; // [5.5, 13.0] Bolt hole diameter (mm)
let ri = t;
let ro = ri + t;
let a = 45.0 * PI() / 180.0;
let seg = length / 2.0 - 25.0;
let pathpts = [];
let p = sketch("XZ").move_to(0, 0).hline_to(seg);
let j = offset;
let prof = polygon("XZ", [[0, 0], [seg, 0], [seg + j, j], [length, j], [length, j + t], [seg + j - t * 0.4142, j + t], [seg - t * 0.4142, t], [0, t]]);
let bar = prof.to_face().extrude([0, width, 0]);
bar = bar.fillet(ri, bar.edges("|Y").filter(|e| (e.center().x - seg).abs() < 0.01 && e.center().z.abs() < 0.01))
    .fillet(ri, bar.edges("|Y").filter(|e| (e.center().x - (seg + j - t * 0.4142)).abs() < 0.01));
let hd = min(hole_d, width - 6.0);
for x in [15.0, 45.0] {
    bar -= cylinder([x, width / 2.0, -1], "Z", hd / 2.0, t + 2.0);
    bar -= cylinder([length - x, width / 2.0, j - 1.0], "Z", hd / 2.0, t + 2.0);
}
bar
