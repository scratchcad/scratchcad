// 4 inch Sch 40 PVC grow tower top cap: slip cap for 114.3 mm pipe (114.6 mm bore, 30 mm skirt, 3.5 mm wall) with a 4 mm top, a 26.9 mm centre hole for a 3/4 inch pump riser in a 36 mm boss 6 mm tall, and four 3 mm top ribs 5 mm tall
let pipe_od = 114.3; // [60.3, 168.3] Pipe outside diameter (mm)
let skirt = 30.0; // [15.0, 50.0] Skirt depth (mm)
let riser_hole = 26.9; // [10.0, 34.0] Riser hole diameter (mm)
let ribs = 4; // [0, 8] Number of top ribs
const wall = 3.5;
const top = 4.0;
let ri = pipe_od / 2.0 + 0.15;
let ro = ri + wall;
let hr = min(riser_hole / 2.0, ri / 2.0);
let br = hr + 4.5;
let cap = cylinder([0, 0, 0], "Z", ro, skirt + top) - cylinder([0, 0, -1.0], "Z", ri, skirt + 1.0);
let parts = [cap, cylinder([0, 0, skirt + top - 0.5], "Z", br, 6.5)];
for i in 0..ribs {
    parts.push(box_from_corners([br - 1.0, -1.5, skirt + top - 0.5], [ro - 3.0, 1.5, skirt + top + 5.0]).rotate_z(i.to_float() * 360.0 / ribs.to_float() + 45.0));
}
fuse_all(parts) - cylinder([0, 0, skirt - 1.0], "Z", hr, top + 10.0)
