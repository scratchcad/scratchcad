// Round tap turner: 160 mm lever with a 58 mm ring that grips round tap heads up to 50 mm on three thumbscrew bosses
let tap_diameter = 50.0; // [30.0, 70.0] Largest tap head diameter (mm)
let lever_length = 160.0; // [100.0, 220.0] Lever length (mm)
let ring_height = 18.0; // [12.0, 28.0] Ring height (mm)
let wall = 4.0; // [3.0, 6.0] Ring wall (mm)
let ri = tap_diameter / 2.0 + 1.0;
let ro = ri + wall;
let ring = cylinder(ro, ring_height) - cylinder([0, 0, -1.0], "Z", ri, ring_height + 2.0);
let lever = box_from_corners([ro - 2.0, -9.0, ring_height - 10.0], [lever_length, 9.0, ring_height]).fillet(8.9, "|Z and >X");
let parts = [ring, lever];
let holes = [];
for i in 0..3 {
    let a = 60.0 + i.to_float() * 120.0;
    parts.push(cylinder([ro - 1.0, 0, ring_height / 2.0], "X", 5.5, 8.0).rotate_z(a));
    holes.push(cylinder([ri - 1.0, 0, ring_height / 2.0], "X", 2.1, wall + 12.0).rotate_z(a));
}
fuse_all(parts) - compound(holes)
