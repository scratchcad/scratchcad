// Kart steering wheel dish spacer 30 mm tall: 84 mm disc ends 5 mm thick joined by a 50 mm hollow core (40 mm bore), three M6 clearance holes (6.4 mm) through on a 70 mm PCD in 14 mm bosses, and 1 mm chamfers on the outer edges
let height = 30.0; // [10.0, 60.0] Spacer height (mm)
let pcd = 70.0; // [56.0, 76.0] Bolt circle diameter (mm)
let disc_d = 84.0; // [70.0, 100.0] Disc diameter (mm)
const plate_t = 5.0;
let dd = max(disc_d, pcd + 14.0);
let disc = cylinder([0, 0, 0], "Z", dd / 2.0, plate_t);
let disc = disc.chamfer(1.0, disc.edges("<Z"));
let top = cylinder([0, 0, height - plate_t], "Z", dd / 2.0, plate_t);
let top = top.chamfer(1.0, top.edges(">Z"));
let parts = [disc, top, cylinder([0, 0, plate_t - 0.5], "Z", 25.0, height - 2.0 * plate_t + 1.0)];
let cuts = [cylinder([0, 0, -1.0], "Z", 20.0, height + 2.0)];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    let p = [pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), 0.0];
    parts.push(cylinder([p[0], p[1], plate_t - 0.5], "Z", 7.0, height - 2.0 * plate_t + 1.0));
    cuts.push(cylinder([p[0], p[1], -1.0], "Z", 3.2, height + 2.0));
}
fuse_all(parts) - fuse_all(cuts)
