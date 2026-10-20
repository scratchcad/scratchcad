// Highlighter stand for 6 markers: stepped block, 2 rows of 3 angled holes 17 mm across (fits chisel highlighters), 30 mm deep, back row 20 mm higher, holes lean back 12 degrees, 2 mm chamfered mouths
let per_row = 3; // [2, 6] Holes per row
let hole_d = 17.0; // [12.0, 22.0] Hole diameter (mm)
let hole_depth = 30.0; // [20.0, 45.0] Hole depth (mm)
let step = 20.0; // [10.0, 35.0] Back row step (mm)
let lean = 12.0; // [0.0, 20.0] Lean back (degrees)

const gap = 6.0;
const front_h = 40.0;
let pitch = hole_d + gap;
let w = per_row * pitch + gap;
let drift = hole_depth * sin(lean * PI() / 180.0);
let row_d = hole_d + 2.0 * gap + drift;
let front = box_from_corners([0, 0, 0], [w, row_d, front_h]);
let back = box_from_corners([0, row_d, 0], [w, 2.0 * row_d, front_h + step]);
let stand = front + back;
stand = stand.fillet(4.0, stand.edges("|Z").filter(|e| e.center().y < 0.01 || e.center().y > 2.0 * row_d - 0.01));
let cuts = [];
for r in 0..2 {
    let zt = front_h + r * step;
    let yc = row_d * r + row_d / 2.0 + drift / 2.0;
    for i in 0..per_row {
        let x = gap + hole_d / 2.0 + i * pitch;
        let h = cylinder([0, 0, -hole_depth], "Z", hole_d / 2.0, hole_depth + 3.0) + cone(hole_d / 2.0, hole_d / 2.0 + 5.0, 5.0).translate([0, 0, -2.0]);
        cuts.push(h.rotate_x(-lean).translate([x, yc, zt]));
    }
}
stand - fuse_all(cuts)
