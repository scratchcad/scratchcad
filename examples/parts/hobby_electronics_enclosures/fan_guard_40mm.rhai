// 40 mm fan finger guard: 40 x 40 x 1.6 mm frame, 3.4 mm holes on 32 mm square, 38 mm opening with 3 concentric rings 1.2 mm wide, 4 spokes 1.6 mm, 10 mm centre hub
let size = 40.0; // [30.0, 92.0] Fan size (mm)
let hole_spacing = 32.0; // [24.0, 82.5] Hole spacing (mm)
let thick = 1.6; // [1.2, 3.0] Guard thickness (mm)
let rings = 3; // [1, 6] Number of rings
let ring_w = 1.2; // [0.8, 2.0] Ring width (mm)
let spokes = 4; // [3, 8] Number of spokes
let hs = min(hole_spacing, size - 6.0);
let ro = min(size / 2.0 - 1.0, hs / 2.0 * 1.414 - 2.5);
let frame = box_centered(size, size, thick).translate([0, 0, thick / 2.0]);
let frame = frame.fillet(3.0, frame.edges("|Z"));
let frame = frame - cylinder([0, 0, -1], "Z", ro, thick + 2.0);
let parts = [frame, cylinder(5.0, thick)];
let gap = (ro - 5.0) / (rings.to_float() + 1.0);
for k in 1..=rings {
    let r = 5.0 + k.to_float() * gap;
    let rw = min(ring_w, gap - 0.6);
    parts.push(cylinder(r + rw / 2.0, thick) - cylinder([0, 0, -1], "Z", r - rw / 2.0, thick + 2.0));
}
for k in 0..spokes {
    parts.push(box_from_corners([4.0, -0.8, 0], [ro + 0.5, 0.8, thick]).rotate_z(k.to_float() * 360.0 / spokes.to_float() + 45.0));
}
let holes = [];
for x in [-hs / 2.0, hs / 2.0] {
    for y in [-hs / 2.0, hs / 2.0] {
        holes.push(cylinder([x, y, -1], "Z", 1.7, thick + 2.0));
    }
}
fuse_all(parts) - compound(holes)
