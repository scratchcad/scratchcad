// Three-piece food tin, 300 x 407 (76 mm diameter, 113 mm tall over the seams): 0.5 mm body wall with eight 0.8 mm deep panel beads, double seams 2.8 mm tall at both ends, countersunk ends
let diameter = 76.0; // [50.0, 160.0] Body diameter (mm)
let height = 113.0; // [50.0, 180.0] Height over the seams (mm)
let beads = 8; // [0, 16] Number of panel beads
let bead_depth = 0.8; // [0.3, 1.5] Bead depth (mm)
let sheet = 0.5; // [0.25, 1.0] Wall thickness shown (mm)
let r = diameter / 2.0;
let zb0 = height * 0.18;
let zb1 = height * 0.82;
// wall profile sampled every millimetre, beads as cosine dips
let outer_pts = [];
let n = (height - 6.0).to_int();
for i in 0..=n {
    let z = 3.0 + i.to_float() * (height - 6.0) / n.to_float();
    let dip = if beads > 0 && z > zb0 && z < zb1 {
        let ph = (z - zb0) / (zb1 - zb0) * beads.to_float();
        bead_depth * 0.5 * (1.0 - (ph * 2.0 * PI()).cos())
    } else { 0.0 };
    outer_pts.push([r - dip, z]);
}
let pts = [];
for p in outer_pts { pts.push([p[0], 0, p[1]]); }
let inner_rev = [];
for p in outer_pts { inner_rev.insert(0, [p[0] - sheet, 0, p[1]]); }
let body = polygon(pts + inner_rev).to_face().revolve("Z", 360);
// ends: double seam ring plus a countersunk panel
let ends = [];
// seams overlap the body by 0.5 mm, panels reach into the wall
for z in [0.0, height - 3.5] {
    let seam = cylinder([0, 0, z], "Z", r + 1.4, 3.5) - cylinder([0, 0, z - 1.0], "Z", r - 1.2, 5.5);
    let panel_z = if z < 1.0 { 3.5 } else { height - 4.0 };
    let panel = cylinder([0, 0, panel_z], "Z", r - sheet / 2.0, sheet);
    ends.push(seam);
    ends.push(panel);
}
fuse_all([body] + ends)
