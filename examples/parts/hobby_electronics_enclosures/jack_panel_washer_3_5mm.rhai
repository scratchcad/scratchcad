// 3.5 mm panel jack anti-rotation washer (PJ-392 / Thonkiconn M6 bushing): 12 mm OD, 6.2 mm bore, 1 mm thick, 1.5 mm locating peg 1.5 mm tall at 4.6 mm radius, knurled edge
let outer_d = 12.0; // [9.0, 18.0] Outside diameter (mm)
let bore = 6.2; // [4.0, 9.5] Bore diameter (mm)
let thick = 1.0; // [0.6, 2.0] Washer thickness (mm)
let peg_d = 1.5; // [1.0, 2.5] Locating peg diameter (mm)
let peg_h = 1.5; // [0.8, 3.0] Locating peg height (mm)
let notches = 18; // [0, 36] Number of edge notches
let ro = max(outer_d / 2.0, bore / 2.0 + peg_d + 1.0);
let rp = (ro + bore / 2.0) / 2.0;
let washer = cylinder(ro, thick) - cylinder([0, 0, -1], "Z", bore / 2.0, thick + 2.0);
let peg = cylinder([rp, 0, -peg_h], "Z", peg_d / 2.0, peg_h + 0.5);
let cuts = [];
for k in 0..notches {
    let a = (k.to_float() + 0.5) * 360.0 / notches.to_float();
    cuts.push(cylinder([ro + 0.15, 0, -1], "Z", 0.4, thick + 2.0).rotate_z(a));
}
let w = washer + peg;
if cuts.len() > 0 { w - compound(cuts) } else { w }
