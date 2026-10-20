// 1/2 in (13 mm) garden hose mender: double barbed coupler 70 mm long, 9 mm bore, central 22 mm hex stop collar 8 mm wide
let hose_bore = 13.0; // [10.0, 19.0] Hose inside diameter (mm)
let tail_length = 30.0; // [18.0, 45.0] Barbed tail length (mm)
let barbs = 3; // [2, 5] Barbs per tail
let hex_size = 22.0; // [16.0, 30.0] Collar width across flats (mm)
let bore = 9.0; // [5.0, 14.0] Bore diameter (mm)
let rb = hose_bore / 2.0 + 0.5;
let rs = hose_bore / 2.0 - 0.8;
let rbore = min(bore / 2.0, rs - 1.2);
let step = tail_length / barbs.to_float();
let pts = [[0, 0, 4.0]];
for i in 0..barbs {
    let z = 4.0 + i.to_float() * step;
    pts.push([rs, 0, z]);
    pts.push([rb, 0, z + 1.0]);
}
pts.push([rs, 0, 4.0 + tail_length]);
pts.push([0, 0, 4.0 + tail_length]);
let tail = polygon(pts).to_face().revolve("Z", 360);
let rc = hex_size / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let collar = polygon(hp).to_face().extrude(8.0).translate([0, 0, -4.0]).chamfer(0.8, ">Z or <Z");
let part = fuse_all([collar, tail.translate([0, 0, -0.1]), tail.mirror("XY").translate([0, 0, 0.1])]);
part - cylinder([0, 0, -tail_length - 10.0], "Z", rbore, 2.0 * tail_length + 20.0)
