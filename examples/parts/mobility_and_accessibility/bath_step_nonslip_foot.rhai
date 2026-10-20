// Bath step foot: replacement non-slip foot for a bath step, 60 mm diameter x 18 mm, 30 degree chamfered sides, 6 suction-style 1.5 mm concentric rings underneath, 8 mm mounting boss bore for a 6 mm push-in stem with 4 barbs
// # Foot
let diameter = 60.0; // [40.0, 80.0] Foot diameter (mm)
let height = 18.0; // [12.0, 25.0] Foot height (mm)
let rings = 6; // [3, 9] Number of grip rings
// # Stem
let stem_d = 6.0; // [5.0, 10.0] Stem diameter (mm)
let stem_length = 20.0; // [12.0, 30.0] Stem length (mm)
let r = diameter / 2.0;
let foot = sketch("XZ").move_to(0, 0).hline_to(r).vline(height * 0.35).line_to(r - height * 0.65 * 0.577, height).hline_to(0).close().to_face().revolve("Z", 360);
let step = (r - 6.0) / rings.to_float();
let gs = [];
for i in 0..rings {
    let rr = 5.0 + i.to_float() * step;
    gs.push(cylinder([0, 0, -1.0], "Z", rr + 0.75, 2.5) - cylinder([0, 0, -2.0], "Z", rr - 0.75, 5.0));
}
let stem = cylinder([0, 0, height - 0.01], "Z", stem_d / 2.0, stem_length);
let barbs = [];
for i in 0..4 {
    barbs.push(cone(stem_d / 2.0 + 0.8, stem_d / 2.0, 2.5).translate([0, 0, height + 4.0 + i.to_float() * (stem_length - 6.0) / 4.0]));
}
foot - fuse_all(gs) + stem + fuse_all(barbs)
