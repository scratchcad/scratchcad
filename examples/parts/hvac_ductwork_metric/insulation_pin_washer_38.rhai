// Self-locking duct insulation pin washer: 38 mm disc 1 mm thick with a 3 mm conical dome, 2.7 mm pin hole with 4 radial slits forming spring petals, 8 embossed ribs
let d = 38.0; // [25.0, 50.0] Washer diameter (mm)
let t = 1.0; // [0.6, 2.0] Thickness (mm)
let dome = 3.0; // [1.0, 5.0] Dome height (mm)
let pin = 2.7; // [2.0, 4.0] Pin hole diameter (mm)
let rib_count = 8; // [0, 12] Number of embossed ribs
let r = d / 2.0;
let rd = r * 0.45;
let prof = polygon([[pin / 2.0, 0, dome], [rd, 0, 0], [r, 0, 0], [r, 0, t], [rd + t * 0.4, 0, t], [pin / 2.0, 0, dome + t]]);
let washer = prof.to_face().revolve("Z", 360);
let ribs = [];
for k in 0..rib_count {
    ribs.push(box_from_corners([rd + 2.0, -0.8, t - 0.2], [r - 2.5, 0.8, t + 0.6]).rotate_z(k.to_float() * 360.0 / rib_count.to_float() + 22.5));
}
if rib_count > 0 { washer = washer + fuse_all(ribs); }
let slits = [];
for k in 0..4 {
    slits.push(box_from_corners([0, -0.25, -1.0], [rd * 0.6, 0.25, dome + t + 2.0]).rotate_z(k.to_float() * 90.0));
}
washer - fuse_all(slits)
