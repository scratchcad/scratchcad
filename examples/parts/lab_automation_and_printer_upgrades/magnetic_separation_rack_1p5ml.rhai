// Magnetic bead separation rack for 6 x 1.5 ml tubes: 120 x 32 x 45 mm block, 11 mm tube holes 36 mm deep at 18 mm pitch, a 12 x 6 x 25 mm magnet pocket behind each tube leaving a 1 mm web, viewing slot in the front
let tubes = 6; // [2, 12] Number of tubes
let pitch = 18.0; // [15.0, 25.0] Tube pitch (mm)
let hole_d = 11.0; // [9.0, 12.0] Tube hole diameter (mm)
let magnet_w = 12.0; // [6.0, 12.0] Magnet width (mm)
let magnet_t = 6.0; // [3.0, 8.0] Magnet thickness (mm)
const height = 45.0;
const depth = 36.0;
const magnet_h = 25.0;
const web = 1.0;
let length = tubes.to_float() * pitch + 12.0;
let width = hole_d + magnet_t + 15.0;
let mw = min(magnet_w, pitch - 4.0);
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
block = block.fillet(2.0, "|Z");
let y_tube = -width / 2.0 + 5.0 + hole_d / 2.0;
let cuts = [];
for i in 0..tubes {
    let x = (i.to_float() - (tubes.to_float() - 1.0) / 2.0) * pitch;
    cuts.push(cylinder([x, y_tube, height - depth], "Z", hole_d / 2.0, depth + 1.0) + cone(1.5, hole_d / 2.0, 6.0).translate([x, y_tube, height - depth - 6.0]));
    let y_mag = y_tube + hole_d / 2.0 + web;
    cuts.push(box_from_corners([x - mw / 2.0, y_mag, height - 5.0 - magnet_h], [x + mw / 2.0, y_mag + magnet_t, height + 1.0]));
}
let slot = box_from_corners([-length / 2.0 + 6.0, -width / 2.0 - 1.0, height - depth + 2.0], [length / 2.0 - 6.0, y_tube - 2.0, height - 10.0]);
block - fuse_all(cuts) - slot
