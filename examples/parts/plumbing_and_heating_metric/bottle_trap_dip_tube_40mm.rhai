// 40 mm bottle trap dip tube: 36 mm tube 1.8 mm wall 75 mm long, 52 mm seating flange 3 mm with sealing bead, 4 notched water-seal ports 8 x 6 mm at the bottom edge
let tube_d = 36.0; // [28.0, 46.0] Tube diameter (mm)
let length = 75.0; // [50.0, 110.0] Tube length (mm)
let wall = 1.8; // [1.2, 3.0] Wall thickness (mm)
let flange_d = 52.0; // [40.0, 64.0] Flange diameter (mm)
let ports = 4; // [2, 8] Number of bottom notches
let ro = tube_d / 2.0;
let ri = ro - wall;
let rf = max(flange_d / 2.0, ro + 3.0);
let pts = [[ri, 0, 0], [ro, 0, 0], [ro, 0, length - 3.0], [rf, 0, length - 3.0], [rf, 0, length], [ri, 0, length]];
let tube = polygon(pts).to_face().revolve("Z", 360);
let bead = polygon([[rf - 3.0, 0, length - 2.5], [rf - 2.0, 0, length - 4.5], [rf - 1.0, 0, length - 2.5]]).to_face().revolve("Z", 360);
let cut = box_from_corners([-4.0, ri - 1.0, -1], [4.0, ro + 1.0, 6.0]);
let cuts = [];
for k in 0..ports {
    cuts.push(cut.rotate_z(k.to_float() * 360.0 / ports.to_float()));
}
tube + bead - compound(cuts)
