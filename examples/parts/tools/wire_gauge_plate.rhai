// Wire gauge plate: 60 mm disc 2 mm thick with sixteen slots for 0.4 to 3.2 mm wire around the edge and a 6 mm centre hole
let d = 60.0; // [40.0, 90.0] Diameter (mm)
let r = d / 2.0;
let plate = cylinder(r, 2.0);
let cuts = [cylinder([0, 0, -1], "Z", 3.0, 4.0)];
for k in 0..16 {
    let w = 0.4 + k.to_float() * 0.1867;
    cuts.push((box_from_corners([r - 6.0, -w / 2.0, -1], [r + 1.0, w / 2.0, 3]) + cylinder([r - 6.0, 0, -1], "Z", w * 0.5 + 0.4, 4.0)).rotate("Z", k.to_float() * 22.5));
}
plate - fuse_all(cuts)
