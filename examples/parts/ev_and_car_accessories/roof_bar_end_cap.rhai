// Aero roof rack crossbar end cap: 80 x 22 mm wing profile (14 mm crown, 8 mm belly), 4 mm cover flange, 20 mm hollow plug for 2 mm bar walls with 3 crush ribs a side
let width = 80.0; // [50.0, 100.0] Bar width (mm)
let crown = 14.0; // [8.0, 18.0] Top curve height (mm)
let belly = 8.0; // [4.0, 12.0] Bottom curve depth (mm)
let bar_wall = 2.0; // [1.5, 3.0] Bar wall thickness (mm)
let plug_len = 20.0; // [10.0, 35.0] Plug length (mm)

const flange_t = 4.0;
const plug_wall = 1.8;
let lens = |w, up, down| {
    sketch("XY").move_to(-w / 2.0, 0).arc_to(0, up, w / 2.0, 0).arc_to(0, -down, -w / 2.0, 0).close().to_face()
};
let flange = lens.call(width + 2.0, crown + 1.0, belly + 1.0).extrude([0, 0, flange_t]);
let pw = width - 2.0 * bar_wall - 2.0 * 0.3 - 4.0;
let pu = crown - bar_wall - 0.3;
let pd = belly - bar_wall - 0.3;
let plug = lens.call(pw, pu, pd).extrude([0, 0, plug_len]).translate([0, 0, flange_t]);
let core = lens.call(pw - 2.0 * plug_wall - 6.0, pu - plug_wall, pd - plug_wall).extrude([0, 0, plug_len + 1.0]).translate([0, 0, flange_t]);
// height of a lens arc (chord w, sagitta s) at x, to seat the crush ribs on the plug surface
let arc_y = |w, sag, x| {
    let r = (w * w / 4.0 + sag * sag) / (2.0 * sag);
    sag - r + sqrt(r * r - x * x)
};
let ribs = [];
for i in 0..3 {
    let x = -pw / 4.0 + i * pw / 4.0;
    ribs.push(box_centered(1.2, 1.2, plug_len - 4.0).translate([x, arc_y.call(pw, pu, x) + 0.3, flange_t + plug_len / 2.0 + 1.0]));
    ribs.push(box_centered(1.2, 1.2, plug_len - 4.0).translate([x, -arc_y.call(pw, pd, x) - 0.3, flange_t + plug_len / 2.0 + 1.0]));
}
fuse_all([flange, plug - core, fuse_all(ribs)])
