// Wall mail sorter with 2 pockets: 240 mm wide back plate 220 mm tall 4 mm thick, two 35 mm deep pockets 110 mm and 90 mm tall for DL/C5 envelopes, 3 mm walls, curved front cut-outs, 2 countersunk 4 mm screws
let width = 240.0; // [180.0, 320.0] Width (mm)
let height = 220.0; // [160.0, 300.0] Back plate height (mm)
let pocket_d = 35.0; // [20.0, 60.0] Pocket depth (mm)
let lower_h = 110.0; // [70.0, 150.0] Lower pocket front height (mm)
let upper_h = 90.0; // [60.0, 130.0] Upper pocket front height (mm)

const back_t = 4.0;
const t = 3.0;
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, back_t, height]);
back = back.fillet(8.0, back.edges("|Y"));
let pocket = |z0, ph, d| {
    let p = box_from_corners([-width / 2.0, back_t - 0.5, z0], [width / 2.0, back_t + d, z0 + ph]);
    p = p - box_from_corners([-width / 2.0 + t, back_t - 1.0, z0 + t], [width / 2.0 - t, back_t + d - t, z0 + ph + 1.0]);
    p - cylinder([0, back_t + d - t - 1.0, z0 + ph + width * 0.25], "Y", width * 0.3, t + 2.0)
};
let up_z = max(t, min(lower_h * 0.75, height - upper_h - 25.0));
let sorter = fuse_all([back, pocket.call(0.0, lower_h, pocket_d), pocket.call(up_z, upper_h, pocket_d * 0.6)]);
for s in [-1.0, 1.0] {
    let x = s * (width / 2.0 - 20.0);
    sorter = sorter - cylinder([x, -1.0, height - 12.0], "Y", 2.1, back_t + 2.0) - cone(2.1, 4.3, 2.3).rotate_x(-90.0).translate([x, back_t - 2.1, height - 12.0]);
}
sorter
