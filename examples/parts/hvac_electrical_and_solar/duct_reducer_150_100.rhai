// Round concentric HVAC duct reducer 6 in to 4 in (150 to 100 mm): 50 mm straight collars, 75 mm cone, 0.8 mm galvanized wall, rolled stiffening bead on the large collar
let large_d = 150.0; // [80.0, 400.0] Large end diameter (mm)
let small_d = 100.0; // [50.0, 300.0] Small end diameter (mm)
let collar = 50.0; // [25.0, 100.0] Collar length (mm)
let cone_len = 75.0; // [30.0, 200.0] Cone length (mm)
let wall = 0.8; // [0.5, 2.0] Sheet thickness (mm)
let r1 = large_d / 2.0;
let r2 = min(small_d, large_d - 10.0) / 2.0;
let z1 = collar;
let z2 = collar + cone_len;
let z3 = z2 + collar;
let zb = collar * 0.4;
const bead = 1.5;
let prof = polygon([
    [r1 - wall, 0, 0], [r1, 0, 0], [r1, 0, zb - 3.0], [r1 + bead, 0, zb], [r1, 0, zb + 3.0], [r1, 0, z1],
    [r2, 0, z2], [r2, 0, z3], [r2 - wall, 0, z3], [r2 - wall, 0, z2],
    [r1 - wall, 0, z1], [r1 - wall, 0, zb + 3.0], [r1 - wall + bead, 0, zb], [r1 - wall, 0, zb - 3.0]]);
prof.to_face().revolve("Z", 360)
