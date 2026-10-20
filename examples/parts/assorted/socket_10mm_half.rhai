// 1/2 inch drive, 10 mm 6-point socket
let length = 38.0; // [30.0, 80.0] Length (mm)
let drive_od = 22.0; // [20.0, 26.0] Drive end diameter (mm)
let nose_od = 15.0; // [14.0, 20.0] Nose diameter (mm)
let hex = 10.0; // [6.0, 19.0] Hex size across flats (mm)
let hex_depth = 10.0; // [6.0, 20.0] Hex depth (mm)
const drive = 12.7; // 1/2 inch square drive
let drive_depth = 12.0; // [8.0, 16.0] Square drive depth (mm)
let body = sketch("XZ").move_to(0, 0).hline_to(drive_od / 2.0).vline_to(drive_depth + 4.0)
    .line_to(nose_od / 2.0, drive_depth + 8.0).vline_to(length).hline_to(0).close().to_face().revolve("Z", 360);
body = body.chamfer(0.8, "%CIRCLE and (<Z or >Z)");
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex_cut = polygon(pts).to_face().extrude(hex_depth + 1.0).translate([0, 0, length - hex_depth]);
let square = box_centered(drive, drive, drive_depth + 1.0).translate([0, 0, (drive_depth - 1.0) / 2.0]);
let relief = cylinder([0, 0, length - hex_depth - 6.0], "Z", hex * 0.4, 7.0);
body - fuse_all([hex_cut, square, relief])
