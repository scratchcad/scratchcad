// Grass topper rear roller end cap for 76 x 3 mm roller tube: 69.6 mm spigot 22 mm long that presses into the tube, an 80 mm flange 5 mm thick, a 47 mm bearing seat 14 mm deep for a 6204 bearing, a 25 mm shaft hole leaving a shoulder behind the bearing, and, where there is room, the spigot hollowed from its inner end between a 2 mm hub wall and a 6 mm outer wall with 6 radial ribs 4 mm thick
let tube_id = 70.0; // [50.0, 100.0] Roller tube bore (mm)
let flange_d = 80.0; // [56.0, 115.0] Flange diameter (mm)
let spigot_len = 22.0; // [14.0, 35.0] Spigot length (mm)
let bearing_od = 47.0; // [35.0, 62.0] Bearing outside diameter (mm)
let bearing_w = 14.0; // [11.0, 18.0] Bearing width (mm)
const flange_t = 5.0;
const spigot_wall = 6.0;
const rib_t = 4.0;
let rs = tube_id / 2.0 - 0.2;
let rf = max(flange_d / 2.0, rs + 3.0);
let rbo = min(bearing_od / 2.0, rs - spigot_wall - 3.0);
let rshaft = min(12.5, rbo - 2.0);
let bw = min(bearing_w, flange_t + spigot_len - 4.0);
let h = flange_t + spigot_len;
let body = cylinder(rf, flange_t) + cylinder([0, 0, flange_t - 0.5], "Z", rs, spigot_len + 0.5);
let body = body.chamfer(1.0, body.edges(">Z"));
let hub_r = rbo + 2.0;
let cutters = [
    cylinder([0, 0, -1.0], "Z", rbo, bw + 1.0),
    cylinder([0, 0, -1.0], "Z", rshaft, h + 2.0),
];
if rs - spigot_wall - hub_r > 3.0 {
    let pocket = cylinder([0, 0, flange_t], "Z", rs - spigot_wall, spigot_len + 1.0) - cylinder([0, 0, flange_t - 1.0], "Z", hub_r, spigot_len + 3.0);
    let ribs = [];
    for i in 0..6 {
        ribs.push(box_from_corners([hub_r - 1.0, -rib_t / 2.0, flange_t - 1.0], [rs - spigot_wall + 1.0, rib_t / 2.0, h + 2.0]).rotate_z(i * 60.0 + 30.0));
    }
    cutters.push(pocket - fuse_all(ribs));
}
body - fuse_all(cutters)
