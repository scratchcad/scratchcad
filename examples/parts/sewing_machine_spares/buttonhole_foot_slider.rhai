// Buttonhole foot slider frame: 50 x 18 x 5 mm frame with 2 mm rounded corners, 32 x 6 mm window for the stitching, 12 x 3 mm button stop slot across the back end, four 2 x 4 mm grip grooves 1 mm deep each side of the window on the underside
let length = 50.0; // [40.0, 70.0] Frame length (mm)
let width = 18.0; // [14.0, 24.0] Frame width (mm)
let window_len = 32.0; // [20.0, 45.0] Window length (mm)
let window_w = 6.0; // [4.0, 8.0] Window width (mm)
const t = 5.0;
let frame = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let frame = frame.fillet(2.0, frame.edges("|Z"));
let wl = min(window_len, length - 20.0);
let ww = min(window_w, width - 8.0);
let cuts = [
    box_centered(wl, ww, 3.0 * t).translate([-3.0, 0, 0]),
    box_centered(3.0, min(12.0, width - 4.0), 3.0 * t).translate([length / 2.0 - 4.0, 0, 0]),
];
for k in [-1.0, 1.0] {
    for i in 0..4 {
        cuts.push(box_centered(2.0, 4.0, 2.0).translate([-length / 2.0 + 8.0 + i.to_float() * 4.0, k * (ww / 2.0 + 2.0 + (width / 2.0 - ww / 2.0 - 2.0) / 2.0), 0]));
    }
}
frame - fuse_all(cuts)
