// Kart wheel spacer for 58 mm PCD hubs: 80 mm disc 10 mm thick with three M8 clearance holes (8.5 mm), a 40 mm centre bore to clear the hub spigot, three 12 mm lightening holes between the bolts and 1 mm chamfers
let thickness = 10.0; // [3.0, 25.0] Spacer thickness (mm)
let pcd = 58.0; // [56.0, 70.0] Wheel stud circle (mm)
let center_bore = 40.0; // [30.0, 42.0] Centre bore (mm)
const disc_d = 80.0;
let disc = cylinder([0, 0, 0], "Z", disc_d / 2.0, thickness);
let disc = disc.chamfer(min(1.0, thickness / 4.0), disc.edges("%CIRCLE"));
let cuts = [cylinder([0, 0, -1.0], "Z", center_bore / 2.0, thickness + 2.0)];
for i in 0..3 {
    let a = (i.to_float() * 120.0) * PI() / 180.0;
    let b = a + 60.0 * PI() / 180.0;
    cuts.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), -1.0], "Z", 4.25, thickness + 2.0));
    let rl = (center_bore / 2.0 + disc_d / 2.0) / 2.0;
    let dl = min(12.0, disc_d / 2.0 - center_bore / 2.0 - 5.0);
    cuts.push(cylinder([rl * cos(b), rl * sin(b), -1.0], "Z", dl / 2.0, thickness + 2.0));
}
disc - fuse_all(cuts)
