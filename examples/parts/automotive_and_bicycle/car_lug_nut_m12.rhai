// M12x1.5 closed-end acorn lug nut: 19 mm hex, 60 deg cone seat, domed cap, 35 mm overall, blind thread_d bore
let af = 19.0; // [17.0, 22.0] Hex across flats (mm)
let thread_d = 12.0; // [10.0, 14.0] Thread diameter (mm)
let rc = af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(18.0).translate([0, 0, 6.0]).chamfer(1.0, ">Z");
let seat = cone(af / 2.0 - 6.0 * (30.0 * PI() / 180.0).tan(), af / 2.0, 6.0);
let dome = cylinder([0, 0, 23.0], "Z", af / 2.0 - 1.5, 7.0) + sphere([0, 0, 30.0], af / 2.0 - 1.5);
let nut = fuse_all([seat, hex, dome]) - box_from_corners([-20, -20, 35.0], [20, 20, 50.0]);
nut - cylinder([0, 0, -1], "Z", thread_d / 2.0 - 0.8, 28.0)
