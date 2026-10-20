// 3/4 in hose Y splitter with two shut-off valves: 33 mm swivel inlet nut, two 26 mm male outlets 35 degrees apart, quarter-turn levers
let spread = 35.0; // [20.0, 60.0] Angle of each outlet from the axis (degrees)
let branch_length = 45.0; // [30.0, 70.0] Branch length (mm)
let nut_diameter = 33.0; // [29.0, 40.0] Inlet nut diameter (mm)
let lever_length = 30.0; // [15.0, 45.0] Lever length (mm)
let rn = nut_diameter / 2.0;
let nut = cylinder([0, 0, 40.0], "Z", rn, 16.0);
let grips = [];
for i in 0..20 {
    grips.push(cylinder([rn + 0.3, 0, 41.0], "Z", 1.0, 14.0).rotate_z(i.to_float() * 18.0));
}
nut = nut - compound(grips);
let trunk = cylinder([0, 0, 14.0], "Z", 10.0, 27.0);
let hub = sphere([0, 0, 14.0], 12.0);
let parts = [nut, trunk, hub];
let bores = [cylinder([0, 0, 43.0], "Z", 12.6, 14.0), cylinder([0, 0, 14.0], "Z", 6.0, 30.0), sphere([0, 0, 14.0], 7.0)];
for s in [-1.0, 1.0] {
    let a = s * spread;
    let branch = fuse_all([
        cylinder([0, 0, 14.0], "-Z", 9.0, branch_length),
        cylinder([0, 0, 14.0 - branch_length + 0.1], "-Z", 13.0, 15.0),
        cylinder([-11.0, 0, 14.0 - branch_length * 0.55], "X", 8.0, 22.0),
        box_from_corners([-2.0, -3.0, 14.0 - branch_length * 0.55 - 2.0], [2.0, lever_length, 14.0 - branch_length * 0.55 + 2.0]).translate([12.0, 0, 0])
    ]);
    parts.push(branch.rotate([0, 0, 14.0], "Y", a));
    bores.push(cylinder([0, 0, 14.0], "-Z", 6.0, branch_length + 20.0).rotate([0, 0, 14.0], "Y", a));
}
fuse_all(parts) - fuse_all(bores)
