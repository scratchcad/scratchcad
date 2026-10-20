// Propagator dome vent: replacement sliding vent for a heated propagator lid, 70 x 30 mm frame plate 2 mm thick with a 50 x 12 mm window and 3 louvre bars, L-section guide rails with 1 mm lips for the slider shutter, 8 mm thumb knob
// # Frame
let frame_l = 70.0; // [50.0, 100.0] Frame length (mm)
let frame_w = 30.0; // [20.0, 45.0] Frame width (mm)
let plate_t = 2.0; // [1.5, 3.0] Plate thickness (mm)
// # Vent
let window_l = 50.0; // [30.0, 80.0] Window length (mm)
let window_w = 12.0; // [8.0, 20.0] Window width (mm)
let louvres = 3; // [1, 6] Number of louvre bars
let frame = box_centered(frame_l, frame_w, plate_t).translate([0, 0, plate_t / 2.0]).fillet(4.0, "|Z");
let wl = min(window_l, frame_l - 12.0);
let ww = min(window_w, frame_w - 10.0);
let window = box_centered(wl, ww, plate_t * 3.0);
let bars = [];
for i in 0..louvres {
    let x = -wl / 2.0 + (i.to_float() + 1.0) * wl / (louvres + 1).to_float();
    bars.push(box_centered(1.5, ww + 1.0, plate_t).translate([x, 0, plate_t / 2.0]));
}
let rails = [];
for s in [-1.0, 1.0] {
    rails.push(box_from_corners([-frame_l / 2.0 + 2.0, s * (ww / 2.0 + 4.0) - 1.0, plate_t - 0.01], [frame_l / 2.0 - 2.0, s * (ww / 2.0 + 4.0) + 1.0, plate_t + 2.5]));
    rails.push(box_from_corners([-frame_l / 2.0 + 2.0, s * (ww / 2.0 + 4.0) - (if s > 0.0 { 2.5 } else { -0.5 }), plate_t + 1.5], [frame_l / 2.0 - 2.0, s * (ww / 2.0 + 4.0) + (if s > 0.0 { -0.5 } else { 2.5 }), plate_t + 2.5]));
}
let knob = cylinder([frame_l / 2.0 - 6.0, 0, plate_t - 0.01], "Z", 4.0, 6.0).chamfer(0.8, ">Z");
(frame - window) + fuse_all(bars) + fuse_all(rails) + knob
