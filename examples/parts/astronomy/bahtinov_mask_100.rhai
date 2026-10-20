// Bahtinov focus mask for a 100 mm aperture: 2 mm plate, 1.5 mm slots on a 3 mm pitch, one half vertical and two quarters at +/-15 degrees, 110 mm rim
let aperture = 100.0; // [70.0, 130.0] Clear aperture (mm)
let pitch = 3.0; // [2.5, 5.0] Slot pitch (mm)
const t = 2.0;
let r = aperture / 2.0;
let n = (aperture / pitch).to_int() + 2;
let a = [];
let b = [];
let c = [];
for i in 0..n {
    let x = -r - pitch + i.to_float() * pitch;
    a.push(box_from_corners([x, -r, -1.0], [x + pitch / 2.0, r, t + 1.0]));
    b.push(box_from_corners([x, -2.0 * r, -1.0], [x + pitch / 2.0, 2.0 * r, t + 1.0]).rotate_z(15.0));
    c.push(box_from_corners([x, -2.0 * r, -1.0], [x + pitch / 2.0, 2.0 * r, t + 1.0]).rotate_z(-15.0));
}
let clear = cylinder([0, 0, -2.0], "Z", r, t + 4.0);
let left = (fuse_all(a) & box_from_corners([-r - 1.0, -r - 1.0, -2.0], [-1.0, r + 1.0, t + 2.0])) & clear;
let top = (fuse_all(b) & box_from_corners([1.0, 1.0, -2.0], [r + 1.0, r + 1.0, t + 2.0])) & clear;
let bot = (fuse_all(c) & box_from_corners([1.0, -r - 1.0, -2.0], [r + 1.0, -1.0, t + 2.0])) & clear;
let plate = cylinder([0, 0, 0], "Z", r + 5.0, t);
let rim = cylinder([0, 0, t - 0.01], "Z", r + 5.0, 8.0) - cylinder([0, 0, t - 1.0], "Z", r + 3.0, 10.0);
plate - left - top - bot + rim
