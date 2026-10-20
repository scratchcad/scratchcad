// NATO rail 50 mm long for a camera cage: 21.2 mm over the 45 degree dovetail, 15.6 mm neck, 9.4 mm tall, 1 mm end chamfers, two M4 countersunk screw holes on 30 mm and a 2 mm safety-pin hole across
let length = 50.0; // [30.0, 150.0] Rail length (mm)
let screw_pitch = 30.0; // [15.0, 120.0] Screw spacing (mm)
let screw_d = 4.5; // [3.4, 6.6] Screw clearance (mm)
const h = 9.4;
let profile = polygon([
    [0, -7.8, 0], [0, 7.8, 0], [0, 7.8, 3.2], [0, 10.6, 6.0], [0, 10.6, 7.4], [0, 8.6, h],
    [0, -8.6, h], [0, -10.6, 7.4], [0, -10.6, 6.0], [0, -7.8, 3.2]]);
let rail = face(profile).extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let rail = rail.chamfer(0.8, rail.edges("|Y and (<X or >X) and >Z"));
let p = min(screw_pitch, length - 12.0);
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * p / 2.0, 0, -1.0], "Z", screw_d / 2.0, h + 2.0));
    cuts.push(cone(screw_d / 2.0, screw_d / 2.0 + 2.5, 2.5).translate([s * p / 2.0, 0, h - 2.5 + 0.01]));
}
cuts.push(cylinder([0, -12.0, 5.0], "Y", 1.0, 24.0));
rail - fuse_all(cuts)
