// Toilet cubicle panel to wall U bracket for 13 mm compact laminate: 50 mm tall U channel with 3 mm walls, a 13.4 mm slot, 25 mm cheeks with two 4.5 mm through-bolt holes, and a 20 mm wall flange each side of the slot with 4.5 mm countersunk screw holes
let panel_t = 13.0; // [10.0, 25.0] Panel thickness (mm)
let height = 50.0; // [30.0, 100.0] Bracket height (mm)
let cheek = 25.0; // [15.0, 40.0] Cheek depth (mm)
let flange = 20.0; // [12.0, 35.0] Wall flange width each side (mm)
const t = 3.0;
let slot = panel_t + 0.4;
let cw = slot + 2.0 * t;
let fl = box_from_corners([-cw / 2.0 - flange, 0, 0], [cw / 2.0 + flange, t, height]);
let fl = fl.fillet(3.0, fl.edges("|Y"));
let cheeks = box_from_corners([-cw / 2.0, t - 0.5, 0], [cw / 2.0, t + cheek, height]);
let body = (fl + cheeks) - box_from_corners([-slot / 2.0, t, -1.0], [slot / 2.0, t + cheek + 1.0, height + 1.0]);
let cuts = [];
for z in [height * 0.25, height * 0.75] {
    cuts.push(cylinder([-cw, t + cheek / 2.0 + 1.5, z], "X", 2.25, 2.0 * cw));
    for s in [-1.0, 1.0] {
        let x = s * (cw / 2.0 + flange / 2.0);
        cuts.push(cylinder([x, -1.0, z], "Y", 2.25, t + 2.0));
        cuts.push(cone(2.25, 4.5, 2.25).rotate_x(-90.0).translate([x, t - 2.24, z]));
    }
}
body - fuse_all(cuts)
