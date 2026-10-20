// Swivel leveling foot M8: 40 mm stud with a 13 mm hex nut, 12 mm ball joint, 40 mm pad 6 mm thick with a 2 mm rubber sole
let stud = 40.0; // [20.0, 80.0] Stud length (mm)
let pad = 40.0; // [25.0, 80.0] Pad diameter (mm)
let rc = 13.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let nut = polygon(hp).to_face().extrude(6.5).translate([0, 0, 20.0]).chamfer(0.6, ">Z or <Z");
let foot = fuse_all([cylinder([0, 0, 12.0], "Z", 4.0, stud), nut, sphere([0, 0, 12.0], 6.0), cylinder([0, 0, 2.0], "Z", pad / 2.0, 6.0).chamfer(1.0, ">Z"), cylinder([0, 0, 5.0], "Z", 8.0, 5.0)]);
compound([foot, cylinder(pad / 2.0 - 1.0, 2.0)])
