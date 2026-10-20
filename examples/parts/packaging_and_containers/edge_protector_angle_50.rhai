// Shipping edge (corner) protector: 50 x 50 mm L-angle, 3 mm thick, 100 mm long, rounded heel and a 90 degree V notch so it can be bent around a corner
let leg = 50.0; // [25.0, 100.0] Leg length (mm)
let thickness = 3.0; // [1.5, 6.0] Thickness (mm)
let length = 100.0; // [50.0, 300.0] Length (mm)
let notches = 1; // [0, 3] Number of bending notches
let t = thickness;
let profile = polygon("YZ", [[0, 0], [leg, 0], [leg, t], [t, t], [t, leg], [0, leg]]);
let angle = profile.to_face().extrude([length, 0, 0]);
angle = angle.fillet(t * 0.9, "|X and <Y and <Z");
let cuts = [];
// V notches in the horizontal leg
for i in 0..notches {
    let x = length * (i.to_float() + 1.0) / (notches.to_float() + 1.0);
    cuts.push(polygon([[x, t + 0.5, -1], [x - (leg - t) * 0.98, leg + 1.0, -1], [x + (leg - t) * 0.98, leg + 1.0, -1]]).to_face().extrude([0, 0, t + 2.0]));
}
// the V notches can overlap at the leg tip, so fuse them before cutting (#58)
if notches > 0 { angle = angle - fuse_all(cuts); }
angle
