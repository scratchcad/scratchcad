// Urinal sensor flush valve cover plate: 120 x 120 mm plate 3 mm thick with 8 mm corner radii and a 10 mm deep skirt 2 mm thick, a 30 x 18 mm sensor window with a 1 mm chamfer, a 12 mm manual override button hole, and two 4.5 mm screw holes 90 mm apart
let size = 120.0; // [90.0, 160.0] Plate size (mm)
let skirt = 10.0; // [5.0, 20.0] Skirt depth (mm)
let window_w = 30.0; // [20.0, 50.0] Sensor window width (mm)
let window_h = 18.0; // [10.0, 30.0] Sensor window height (mm)
const t = 3.0;
const wall = 2.0;
let outer = box_centered(size, size, t + skirt).translate([0, 0, (t + skirt) / 2.0]);
let outer = outer.fillet(8.0, outer.edges("|Z"));
let inner = box_centered(size - 2.0 * wall, size - 2.0 * wall, skirt + 1.0).translate([0, 0, (skirt - 1.0) / 2.0]);
let inner = inner.fillet(6.0, inner.edges("|Z"));
let plate = outer - inner;
let wy = size * 0.2;
let win = box_centered(window_w, window_h, t + 4.0).translate([0, wy, skirt + t / 2.0]);
let hs = size / 2.0 - 15.0;
let cuts = [win, cylinder([0, -size * 0.15, skirt - 1.0], "Z", 6.0, t + 2.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * hs, -size * 0.35, skirt - 1.0], "Z", 2.25, t + 2.0));
}
let body = plate - fuse_all(cuts);
let hw = window_w / 2.0 + 1.0;
let hh = window_h / 2.0 + 1.0;
body.chamfer(1.0, body.edges(">Z").filter(|e| e.center().x.abs() < hw && (e.center().y - wy).abs() < hh))
