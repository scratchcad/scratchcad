// Swivel-blade deburring tool: 14 mm hexagonal grip 110 mm long, 8 mm nose, 3.2 mm swivel blade holder with a hooked blade
let len = 110.0; // [90.0, 140.0] Handle length (mm)
let rc = 14.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let grip = polygon(hp).to_face().extrude(len).chamfer(1.0, ">Z or <Z") - cylinder([0, 0, len - 25.0], "Z", 1.7, 30.0);
let nose = cone(7.0, 4.0, 15.0).translate([0, 0, len]);
let blade = cylinder([0, 0, len + 10.0], "Z", 1.6, 30.0) + circle([0, 0, len + 40.0], [0, 0, 1], 1.0).to_face().sweep(polyline([[0, 0, len + 40.0], [0, 0, len + 48.0], [-6.0, 0, len + 52.0]]));
fuse_all([grip, nose, blade])
