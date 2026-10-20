// Valved holding chamber (inhaler spacer): 50 mm chamber 150 mm long, 2 mm wall, 28 mm mouthpiece, 36 mm MDI boot port, valve seat with 4 spokes
let chamber_diameter = 50.0; // [35.0, 70.0] Chamber diameter (mm)
let chamber_length = 150.0; // [80.0, 220.0] Overall length (mm)
let mouthpiece_diameter = 28.0; // [20.0, 34.0] Mouthpiece diameter (mm)
let port_diameter = 36.0; // [28.0, 45.0] Inhaler boot port diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let rc = chamber_diameter / 2.0;
let rm = min(mouthpiece_diameter / 2.0, rc - 4.0);
let rp = min(port_diameter / 2.0, rc - 2.0);
let L = chamber_length;
let prof = [[0, 0], [rm, 0], [rm, 20.0], [rc, 40.0], [rc, L - 15.0], [rp, L - 5.0], [rp, L], [0, L]];
let pts = [];
for q in prof { pts.push([q[0], 0, q[1]]); }
let outer = polygon(pts).to_face().revolve("Z", 360);
let ipts = [[0, 0, -1.0], [rm - wall, 0, -1.0], [rm - wall, 0, 20.0], [rc - wall, 0, 40.0], [rc - wall, 0, L - 15.0], [rp - wall, 0, L - 5.0], [rp - wall, 0, L + 1.0], [0, 0, L + 1.0]];
let inner = polygon(ipts).to_face().revolve("Z", 360);
let body = outer - inner;
// valve seat ring with spokes at the mouthpiece end of the chamber
let seat = cylinder([0, 0, 24.0], "Z", rm + 2.0, 2.0) - cylinder([0, 0, 23.0], "Z", rm - wall - 3.0, 4.0);
let spokes = [cylinder([0, 0, 24.0], "Z", 2.5, 2.0)];
for i in 0..4 {
    spokes.push(box_centered(2.0 * (rm - wall - 2.5), 1.5, 2.0).translate([0, 0, 25.0]).rotate_z(i.to_float() * 45.0));
}
fuse_all([body, seat] + spokes)
