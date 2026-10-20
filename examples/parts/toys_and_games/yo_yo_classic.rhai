// Classic yo-yo: two 56 mm rounded halves 16 mm thick, 4 mm gap with a 6 mm axle
let d = 56.0; // [40.0, 70.0] Diameter (mm)
let gap = 4.0; // [2.0, 8.0] String gap (mm)
let r = d / 2.0;
let half = sketch("XZ").move_to(0, 0).line_to(r - 5.0, 0).arc_to(r, 6.0, r - 3.0, 16.0).line_to(0, 16.0).close().to_face().revolve("Z", 360) - cylinder([0, 0, 14.0], "Z", r - 8.0, 5.0);
let axle = cylinder([0, 0, -3.0], "Z", 3.0, gap + 6.0);
fuse_all([half.mirror([0, 0, 1]).translate([0, 0, -gap / 2.0]), half.translate([0, 0, gap / 2.0]), axle]).rotate_x(90.0)
