// Uniseal-style tank grommet for a 1 inch pipe: 33.4 mm pipe bore with three 0.6 mm sealing rings inside, a 44 mm body for a 1-3/4 inch (44.5 mm) hole saw cut, a 4 mm wide groove that takes tank walls up to 4 mm, and 52 mm flanges 3 mm thick each side
let pipe_od = 33.4; // [21.3, 60.3] Pipe outside diameter (mm)
let tank_wall = 4.0; // [1.5, 8.0] Tank wall thickness (mm)
let flange_d = 52.0; // [40.0, 90.0] Flange diameter (mm)
const ft = 3.0;
let ri = pipe_od / 2.0 - 0.6;
let rg = pipe_od / 2.0 + 5.3;
let rf = max(flange_d / 2.0, rg + 4.0);
let w = tank_wall;
let h = 2.0 * ft + w;
let pts = [[ri, 0, 0], [rf - 1.0, 0, 0], [rf, 0, 1.0], [rf, 0, ft], [rg, 0, ft], [rg, 0, ft + w], [rf, 0, ft + w], [rf, 0, h - 1.0], [rf - 1.0, 0, h], [ri, 0, h]];
let body = face(polygon(pts)).revolve("Z", 360.0);
let bore = cylinder([0, 0, -1.0], "Z", ri + 0.6, h + 2.0);
let rings = [];
for k in 1..4 {
    let z = h * k.to_float() / 4.0;
    rings.push(face(polygon([[ri, 0, z - 0.6], [ri + 0.7, 0, z - 0.6], [ri + 0.7, 0, z + 0.6], [ri, 0, z + 0.6]])).revolve("Z", 360.0));
}
(body - bore) + fuse_all(rings)
