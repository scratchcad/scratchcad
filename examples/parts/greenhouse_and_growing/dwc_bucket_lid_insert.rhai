// DWC bucket lid insert: deep-water-culture lid for a 5 gallon bucket, 300 mm disc 4 mm thick with a 152 mm (6 in) net pot hole, 8 mm air line grommet hole, 16 mm fill port, 10 mm drop skirt and 6 stiffening ribs
// # Lid
let lid_d = 300.0; // [250.0, 330.0] Lid diameter (mm)
let thickness = 4.0; // [3.0, 6.0] Lid thickness (mm)
let skirt = 10.0; // [5.0, 20.0] Skirt depth (mm)
// # Holes
let pot_hole = 152.0; // [75.0, 200.0] Net pot hole diameter (mm)
let air_line = 8.0; // [5.0, 12.0] Air line hole diameter (mm)
let fill_port = 16.0; // [10.0, 25.0] Fill port diameter (mm)
let ribs = 6; // [3, 10] Number of stiffening ribs
let R = lid_d / 2.0;
let disc = cylinder(R, thickness);
let sk = cylinder([0, 0, -skirt], "Z", R, skirt + 0.01) - cylinder([0, 0, -skirt - 1.0], "Z", R - 2.5, skirt + 1.0);
let pr = min(pot_hole / 2.0, R - 40.0);
let rs = [];
for i in 0..ribs {
    rs.push(box_from_corners([pr, -1.5, -8.0], [R - 2.0, 1.5, 0.01]).rotate_z(i.to_float() * 360.0 / ribs.to_float() + 180.0 / ribs.to_float()));
}
let collar = cylinder([0, 0, -8.0], "Z", pr + 4.0, 8.01);
let body = disc + sk + fuse_all(rs) + collar;
let mid = (pr + R) / 2.0;
let holes = [cylinder([0, 0, -20.0], "Z", pr, 40.0), cylinder([mid, 0, -20.0], "Z", air_line / 2.0, 40.0), cylinder([-mid, 0, -20.0], "Z", fill_port / 2.0, 40.0)];
body - compound(holes)
