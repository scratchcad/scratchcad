// Thread adapter 1/4-20 male to 3/8-16 female: 15 mm hex body 12 mm tall, 3/8-16 female bore (8.0 mm tap drill, 10 mm deep with 1.59 mm-pitch ridges), 1/4-20 male stud 9 mm (ridged at 1.27 mm), 1 mm slot for a screwdriver
let hex = 15.0; // [12.0, 22.0] Hex across flats (mm)
let body_height = 12.0; // [10.0, 20.0] Body height (mm)
let stud_length = 9.0; // [5.0, 12.0] Male stud length (mm)
let bore_depth = 10.0; // [6.0, 14.0] Female bore depth (mm)
let rc = hex / 2.0 / (30.0 * PI() / 180.0).cos();
let pts = [];
for k in 0..6 { let a = (k.to_float() * 60.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = polygon("XY", pts).to_face().extrude([0, 0, body_height]);
let b = body & cone(rc + 1.0, rc - 2.0, body_height + 0.01).translate([0, 0, 0]) & cone(rc - 2.0, rc + 1.0, body_height + 0.01).translate([0, 0, -0.005]).rotate_x(180.0).translate([0, 0, body_height]);
// female 3/8-16: tap-drill bore with inward ridges at the thread pitch
let bore = cylinder([0, 0, -1.0], "Z", 4.75, bore_depth + 1.0);
let ridges = [];
let nf = (bore_depth / 1.5875).floor().to_int();
for i in 0..nf { ridges.push(cylinder([0, 0, 0.6 + i.to_float() * 1.5875], "Z", 4.8, 0.6) - cylinder([0, 0, i.to_float() * 1.5875], "Z", 4.0, 2.0)); }
// male 1/4-20 stud on top
let top = body_height;
let sp = [[0.0, top - 0.01], [2.6, top - 0.01]];
let n = (stud_length / 1.27).floor().to_int();
for i in 0..n {
    let z = top + i.to_float() * 1.27;
    sp.push([3.175, z + 0.45]);
    sp.push([3.175, z + 0.65]);
    sp.push([2.6, z + 1.1]);
}
sp.push([2.6, top + stud_length - 0.5]);
sp.push([2.1, top + stud_length]);
sp.push([0.0, top + stud_length]);
let stud = polygon("XZ", sp).to_face().revolve([0, 0, 0], "Z", 360);
let slot = box_centered(1.0, 8.0, 2.0).translate([0, 0, top + stud_length]);
(b - bore + fuse_all(ridges) + stud) - slot
