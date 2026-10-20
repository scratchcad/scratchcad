// Sharps container wall bracket for a 7 litre bin: 200 x 150 mm back plate 3 mm thick, two side channels with 8 mm slots that take the bin's hanging tabs, a 40 mm bottom ledge and four 5 mm screw holes
let width = 200.0; // [150.0, 280.0] Bracket width (mm)
let height = 150.0; // [100.0, 220.0] Bracket height (mm)
let ledge = 40.0; // [25.0, 60.0] Bottom ledge depth (mm)
const t = 3.0;
const slot = 8.0;
let parts = [
    box_from_corners([-width / 2.0, -t, 0], [width / 2.0, 0, height]),
    box_from_corners([-width / 2.0, -t, 0], [width / 2.0, ledge, t]),
    box_from_corners([-width / 2.0, ledge - t, 0], [width / 2.0, ledge, 12.0]),
];
for sx in [-1.0, 1.0] {
    let x0 = sx * width / 2.0;
    parts.push(box_from_corners([x0 - t, -0.01, 30.0], [x0, slot + t, height]).translate([if sx < 0.0 { t } else { 0.0 }, 0, 0]));
    parts.push(box_from_corners([x0 - 14.0, slot, 30.0], [x0, slot + t, height]).translate([if sx < 0.0 { 14.0 } else { 0.0 }, 0, 0]));
}
let b = fuse_all(parts);
let holes = [];
for x in [-width / 4.0, width / 4.0] {
    for z in [25.0, height - 20.0] { holes.push(cylinder([x, -t - 1.0, z], "Y", 2.5, t + 2.0)); }
}
b - compound(holes)
