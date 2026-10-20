// Patio table umbrella hole ring: 50 mm table hole, 38 mm pole, 70 mm flange 3 mm, 20 mm sleeve, 4 flex fingers
let hole = 50.0; // [40.0, 60.0] Table hole diameter (mm)
let pole = 38.0; // [30.0, 48.0] Pole diameter (mm)
let flange = 70.0; // [55.0, 90.0] Flange diameter (mm)
let sleeve = 20.0; // [10.0, 30.0] Sleeve depth (mm)
let r = cylinder(flange / 2.0, 3.0) + cylinder([0, 0, -sleeve], "Z", hole / 2.0 - 0.3, sleeve + 0.01);
let rr = r - cylinder([0, 0, -sleeve - 1.0], "Z", hole / 2.0 - 2.5, sleeve + 5.0);
let fingers = [];
for k in 0..4 { fingers.push((cylinder([0, 0, -1.0], "Z", hole / 2.0 - 2.49, 4.0) - cylinder([0, 0, -2.0], "Z", pole / 2.0 + 0.3, 6.0)) & box_from_corners([-5.0, 0, -2.0], [5.0, hole, 4.0]).rotate_z(k.to_float() * 90.0)); }
rr + fuse_all(fingers)
