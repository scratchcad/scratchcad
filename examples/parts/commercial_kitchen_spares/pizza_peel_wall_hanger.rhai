// Pizza peel wall hanger: 80 x 60 mm wall plate 6 mm thick with two 5 mm countersunk holes and two 70 mm angled pegs 12 mm diameter, 50 mm apart, tilted up 10 degrees to cradle a 40 mm peel handle
let peg_len = 70.0; // [40.0, 100.0] Peg length (mm)
let gap = 50.0; // [30.0, 70.0] Peg spacing (mm)
let tilt = 10.0; // [0.0, 20.0] Peg tilt (degrees)
const peg_d = 12.0;
const t = 6.0;
let w = gap + 30.0;
let plate = box_from_corners([-w / 2.0, -t, -30.0], [w / 2.0, 0, 30.0]);
plate = plate.fillet(5.0, plate.edges("|Y"));
let pegs = [];
for sx in [-1.0, 1.0] {
    let p = cylinder([0, -1.0, 0], "Y", peg_d / 2.0, peg_len + 1.0).rotate_x(tilt).translate([sx * gap / 2.0, 0, -10.0]);
    pegs.push(p);
}
let holes = [];
for z in [-20.0, 20.0] {
    holes.push(cylinder([0, -t - 1.0, z], "Y", 2.5, t + 2.0));
    holes.push(cone(5.0, 2.5, 2.5).rotate_x(90.0).translate([0, 0.01, z]));
}
plate + fuse_all(pegs) - fuse_all(holes)
