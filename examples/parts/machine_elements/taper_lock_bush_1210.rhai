// Taper-lock bush 1210 for a 25 mm shaft: 25.4 mm long, 8 deg included taper from 47.6 mm, 8 mm keyway, axial split, two half-thread holes 3/8 in BSW
let bore = 25.0; // [11.0, 29.2] Bore diameter (mm)
let large_diameter = 47.6; // [43.0, 60.0] Large end diameter (mm)
let length = 25.4; // [15.0, 40.0] Length (mm)
const taper = 8.0;
const screw = 8.6;
let r1 = large_diameter / 2.0;
let r2 = r1 - length * (taper / 2.0 * PI() / 180.0).tan();
let bush = cone(r1, r2, length);
let kw = if bore <= 30.0 { 8.0 } else { 10.0 };
bush = bush - fuse_all([cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0), box_from_corners([-kw / 2.0, 0, -1], [kw / 2.0, bore / 2.0 + 3.3, length + 1.0])]);
bush = bush - box_from_corners([-0.6, -r1 - 1.0, -1], [0.6, 0, length + 1.0]);
let pcd = (bore / 2.0 + r2) / 2.0 + 0.5;
let holes = [];
for a in [60.0, 240.0] {
    let ar = a * PI() / 180.0;
    holes.push(cylinder([pcd * ar.cos(), pcd * ar.sin(), -1], "Z", screw / 2.0, length + 2.0));
}
bush - compound(holes)
