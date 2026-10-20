// Insect mesh hoop clip: snap-on clip that fixes insect netting or fleece to a 25 mm crop-cover hoop, 30 mm wide, 3 mm wall, 260 degree wrap with flared lead-ins, 8 grip ribs on the inside face
// # Hoop
let hoop = 25.0; // [16.0, 32.0] Hoop tube diameter (mm)
let width = 30.0; // [15.0, 45.0] Clip width (mm)
let wall = 3.0; // [2.0, 5.0] Wall thickness (mm)
// # Grip
let ribs = 8; // [0, 14] Number of grip ribs
let mouth = 0.62; // [0.5, 0.8] Mouth opening (fraction of hoop diameter)
let r = hoop / 2.0 + 0.6;
let ro = r + wall;
let ring = cylinder([0, 0, 0], "Z", ro, width) - cylinder([0, 0, -1.0], "Z", r, width + 2.0);
let gap = box_from_corners([-hoop * mouth / 2.0, 0, -1.0], [hoop * mouth / 2.0, ro + 1.0, width + 1.0]);
let flares = [];
for s in [-1.0, 1.0] {
    let x = s * (hoop * mouth / 2.0 + wall / 2.0);
    let y = (ro * ro - (hoop * mouth / 2.0 + wall) * (hoop * mouth / 2.0 + wall)).sqrt();
    flares.push(box_centered(wall, 6.0, width).rotate_z(-s * 30.0).translate([x + s * 1.5, y + 2.0, width / 2.0]));
}
let rs = [];
for i in 0..ribs {
    let a = 140.0 + i.to_float() * 260.0 / max(ribs - 1, 1).to_float();
    rs.push(box_centered(1.0, 1.0, width - 4.0).translate([r - 0.2, 0, width / 2.0]).rotate_z(a));
}
let clip = (ring - gap) + fuse_all(flares);
if ribs > 0 { clip + fuse_all(rs) } else { clip }
