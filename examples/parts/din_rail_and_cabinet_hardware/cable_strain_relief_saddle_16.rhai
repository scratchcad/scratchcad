// Two-ear strain relief saddle for a 16 mm cable on a cabinet's cable support rail: 20 mm wide, 3 mm thick, 8 mm radius cable seat with 4 x 0.5 mm grip ribs, ears 12 mm long with 5.5 mm holes on 40 mm centres
let cable_d = 16.0; // [6.0, 30.0] Cable diameter (mm)
let width = 20.0; // [12.0, 30.0] Saddle width (mm)
const t = 3.0;
const ear = 12.0;
let rc = cable_d / 2.0;
let ro = rc + t;
let centres = cable_d + 2.0 * t + ear;
let bridge = cylinder([0, -width / 2.0, 0], "Y", ro, width) - cylinder([0, -width, 0], "Y", rc, 2.0 * width) - box_centered(2.0 * ro + 2.0, 2.0 * width, 2.0 * ro).translate([0, 0, -ro]);
let ears = box_from_corners([-centres / 2.0 - ear / 2.0, -width / 2.0, 0], [-rc - 0.5, width / 2.0, t])
    + box_from_corners([rc + 0.5, -width / 2.0, 0], [centres / 2.0 + ear / 2.0, width / 2.0, t]);
let ribs = [];
for k in 0..4 {
    let y = -width / 2.0 + width * (k.to_float() + 0.5) / 4.0;
    let ring = cylinder([0, y - 0.5, 0], "Y", rc + 0.5, 1.0) - cylinder([0, y - 1.0, 0], "Y", rc - 0.5, 2.0);
    ribs.push(ring & box_from_corners([-ro, y - 1.0, 0.5], [ro, y + 1.0, ro]));
}
let holes = cylinder([-centres / 2.0, 0, -1.0], "Z", 2.75, t + 2.0) + cylinder([centres / 2.0, 0, -1.0], "Z", 2.75, t + 2.0);
bridge + ears + fuse_all(ribs) - holes
