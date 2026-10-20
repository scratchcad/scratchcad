// RC 540 motor heatsink clip: 36 mm split ring 12 mm wide with 2 mm walls and 8 radial fins 6 mm tall, open 8 mm gap to clip onto the can
let can = 36.0; // [28.0, 42.0] Motor can diameter (mm)
let fins = 8; // [4, 12] Number of fins
const w = 12.0;
const wall = 2.0;
let r = can / 2.0;
let ring = cylinder([0, 0, 0], "Z", r + wall, w) - cylinder([0, 0, -1.0], "Z", r, w + 2.0);
let f = [];
for i in 0..fins { f.push(box_from_corners([r + wall - 0.5, -0.75, 0], [r + wall + 6.0, 0.75, w]).rotate_z(30.0 + i.to_float() * 300.0 / (fins - 1).to_float())); }
ring + fuse_all(f) - box_from_corners([-4.0, -r - wall - 8.0, -1.0], [4.0, -r + 2.0, w + 1.0])
