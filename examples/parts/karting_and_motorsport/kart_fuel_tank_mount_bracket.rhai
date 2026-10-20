// Kart fuel tank mount bracket: 3 mm saddle plate 30 mm wide spanning two 28 mm frame tubes 80 mm apart, with a 28 mm half-round clip formed under each end, a 30 mm tall upright tab in the middle with an M6 hole (6.4 mm) for the tank strap, and 3 mm rounded corners
let tube_d = 28.0; // [20.0, 32.0] Frame tube diameter (mm)
let tube_spacing = 80.0; // [60.0, 120.0] Tube spacing (mm)
let width = 30.0; // [20.0, 40.0] Bracket width (mm)
let tab_h = 30.0; // [15.0, 50.0] Strap tab height (mm)
const t = 3.0;
let ri = tube_d / 2.0 + 0.2;
let ro = ri + t;
let span = tube_spacing + 2.0 * ro;
let plate = box_from_corners([-span / 2.0, -width / 2.0, ri], [span / 2.0, width / 2.0, ri + t]);
let parts = [plate];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * tube_spacing / 2.0;
    parts.push(cylinder([x, -width / 2.0, 0], "Y", ro, width) - box_from_corners([x - ro - 1.0, -width / 2.0 - 1.0, -ro - 1.0], [x + ro + 1.0, width / 2.0 + 1.0, -ri * 0.4]));
    cuts.push(cylinder([x, -width / 2.0 - 1.0, 0], "Y", ri, width + 2.0));
}
let tab = box_from_corners([-12.0, -t / 2.0, ri + t - 0.5], [12.0, t / 2.0, ri + t + tab_h]);
parts.push(tab.fillet(3.0, tab.edges("|Y and >Z")));
cuts.push(cylinder([0, -5.0, ri + t + tab_h - 9.0], "Y", 3.2, 10.0));
fuse_all(parts) - fuse_all(cuts)
