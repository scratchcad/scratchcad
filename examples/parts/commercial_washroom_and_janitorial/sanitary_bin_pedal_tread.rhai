// Sanitary bin pedal tread: 90 x 45 mm pedal 6 mm thick with 6 mm rounded front corners, seven 1.5 mm anti-slip ribs across the top, and a 12 mm hinge boss 50 mm wide along the back with a 5 mm pivot pin bore, joined to the tread by a 6 mm web
let length = 90.0; // [60.0, 130.0] Tread length (mm)
let depth = 45.0; // [30.0, 70.0] Tread depth (mm)
let ribs = 7; // [3, 12] Number of grip ribs
let pin_d = 5.0; // [3.0, 8.0] Pivot pin bore (mm)
const t = 6.0;
const boss_d = 12.0;
let tread = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, t]);
let tread = tread.fillet(6.0, tread.edges("|Z and >Y"));
let bw = min(50.0, length - 10.0);
let br = boss_d / 2.0;
let boss = cylinder([-bw / 2.0, 0, br], "X", br, bw);
let web = box_from_corners([-bw / 2.0, 0, 0], [bw / 2.0, br, br]);
let parts = [tread, boss, web];
let sp = (depth - br - 8.0) / ribs.to_float();
for i in 0..ribs {
    let y = br + 4.0 + sp * (i.to_float() + 0.5);
    parts.push(box_from_corners([-length / 2.0 + 8.0, y - 1.0, t - 0.5], [length / 2.0 - 8.0, y + 1.0, t + 1.5]));
}
fuse_all(parts) - cylinder([-length, 0, br], "X", min(pin_d / 2.0, br - 2.0), 2.0 * length)
