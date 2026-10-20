// Toggle switch safety guard for 12 mm (15/32 in) bushing toggles: 32 x 20 x 1.5 mm base with 12.2 mm hole and 3 mm anti-rotation tab hole, two 1.8 mm side cheeks 24 mm tall with rounded tops, 10 mm lever gap
let base_l = 32.0; // [24.0, 45.0] Base length (mm)
let base_w = 20.0; // [16.0, 30.0] Base width (mm)
let base_t = 1.5; // [1.0, 3.0] Base thickness (mm)
let bushing = 12.2; // [6.2, 12.7] Bushing hole (mm)
let guard_h = 24.0; // [12.0, 35.0] Guard height (mm)
let gap = 10.0; // [6.0, 16.0] Lever gap between cheeks (mm)
let cheek_t = 1.8; // [1.2, 3.0] Cheek thickness (mm)
let bw = max(base_w, gap + 2.0 * cheek_t + 2.0);
let bl = max(base_l, bushing + 10.0);
let base = box_centered(bl, bw, base_t).translate([0, 0, base_t / 2.0]);
let base = base.fillet(3.0, base.edges("|Z"));
let shapes = [base];
for s in [-1.0, 1.0] {
    let y0 = s * gap / 2.0;
    let y1 = s * (gap / 2.0 + cheek_t);
    let cheek = box_from_corners([-bl / 2.0 + 2.0, min(y0, y1), base_t - 0.5], [bl / 2.0 - 2.0, max(y0, y1), guard_h]);
    shapes.push(cheek.fillet(min(bl / 2.0 - 3.0, guard_h * 0.4), cheek.edges("|Y and >Z")));
}
fuse_all(shapes) - cylinder([0, 0, -1], "Z", bushing / 2.0, base_t + 2.0) - cylinder([bushing / 2.0 + 3.5, 0, -1], "Z", 1.5, base_t + 2.0)
