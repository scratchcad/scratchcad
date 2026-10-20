// Repair stand height clamp collar for a 35 mm mast: 50 mm ring 20 mm tall, 35.2 mm bore, 3 mm split through a 16 mm thick lug block 14 mm long, 6.5 mm cross hole through the lug for the cam lever bolt
let mast_d = 35.0; // [25.0, 45.0] Mast diameter (mm)
let ring_h = 20.0; // [14.0, 30.0] Collar height (mm)
let wall = 7.4; // [5.0, 10.0] Ring wall (mm)
let split = 3.0; // [2.0, 5.0] Split width (mm)
const lug_len = 14.0;
const lug_w = 16.0;
let ri = mast_d / 2.0 + 0.1;
let ro = ri + wall;
let ring = cylinder(ro, ring_h);
let lug = box_from_corners([-lug_w / 2.0, 0, 0], [lug_w / 2.0, ro + lug_len, ring_h]);
let body = ring + lug;
let cuts = fuse_all([
    cylinder([0, 0, -1.0], "Z", ri, ring_h + 2.0),
    box_from_corners([-split / 2.0, 0, -1.0], [split / 2.0, ro + lug_len + 1.0, ring_h + 1.0]),
    cylinder([-lug_w, ro + lug_len / 2.0, ring_h / 2.0], "X", 3.25, 2.0 * lug_w),
]);
body - cuts
