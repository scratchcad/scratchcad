// Straight radiator hose repair joiner for 32 mm hose: 100 mm long, 25 mm bore, 28 mm core with three 33 mm barbs each side, 38 x 4 mm centre stop ring
let hose_id = 32.0; // [16.0, 50.0] Hose inner diameter (mm)
let length = 100.0; // [60.0, 160.0] Overall length (mm)
let wall = 1.5; // [1.0, 4.0] Wall under the barbs (mm)
let barbs = 3; // [1, 5] Number of barbs per side
const ring_w = 4.0;
let r_core = hose_id / 2.0 - 2.0;
let r_barb = hose_id / 2.0 + 0.5;
let r_bore = r_core - wall;
let half = length / 2.0;
let pitch = (half - ring_w / 2.0 - 4.0) / barbs.to_float();
let prof = [[r_bore, 0.0], [r_core - 0.5, 0.0]];
for i in 0..barbs {
    let z = 1.0 + i.to_float() * pitch;
    prof.push([r_core, z]);
    prof.push([r_barb, z + pitch * 0.75]);
    prof.push([r_core, z + pitch * 0.75 + 0.01]);
}
prof.push([r_core, half - ring_w / 2.0]);
prof.push([r_core + 3.0, half - ring_w / 2.0]);
prof.push([r_core + 3.0, half]);
prof.push([r_bore, half]);
let halfpart = polygon("XZ", prof).to_face().revolve("Z", 360);
halfpart + halfpart.mirror([0, 0, half], [0, 0, 1])
