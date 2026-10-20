// M5 flanged nylon-insert prop nut: 8 mm hex 5 mm tall, 12 mm flange 1.5 mm thick, 8 mm nylon dome, 4.2 mm bore
let af = 8.0; // [7.0, 10.0] Hex across flats (mm)
let rc = af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(5.0).translate([0, 0, 1.5]).chamfer(0.4, ">Z");
let nut = fuse_all([cylinder(6.0, 1.5), hex, cylinder([0, 0, 6.4], "Z", af / 2.0 - 0.3, 2.0)]);
nut - cylinder([0, 0, -1], "Z", 2.1, 10.0)
