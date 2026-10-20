// Gastronorm 1/1 pan corner bumper: snaps over the pan's 12 mm rim flange at its 25 mm corner radius, 40 mm legs, 8 mm tall, 3 mm wall with a 2 mm slot for the 1 mm rolled rim
let corner_r = 25.0; // [15.0, 40.0] Pan corner radius (mm)
let leg = 40.0; // [20.0, 60.0] Leg length (mm)
let slot = 2.0; // [1.2, 3.0] Rim slot height (mm)
let grip = 8.0; // [5.0, 10.0] Grip depth over the rim (mm)
const wall = 3.0;
const height = 8.0;

fn quarter_ring(ri, ro, z0, h) {
    let ring = cylinder([0, 0, z0], "Z", ro, h) - cylinder([0, 0, z0 - 1.0], "Z", ri, h + 2.0);
    ring & box_from_corners([0, 0, z0 - 1.0], [ro + 1.0, ro + 1.0, z0 + h + 1.0])
}

let ri = corner_r - grip;
let ro = corner_r + wall;
let body = fuse_all([
    quarter_ring(ri, ro, 0.0, height),
    box_from_corners([ri, -leg, 0], [ro, 0, height]),
    box_from_corners([-leg, ri, 0], [0, ro, height]),
]);
let z0 = height / 2.0 - slot / 2.0;
let cutter = fuse_all([
    quarter_ring(ri - 2.0, corner_r, z0, slot),
    box_from_corners([ri - 2.0, -leg - 1.0, z0], [corner_r, 0, z0 + slot]),
    box_from_corners([-leg - 1.0, ri - 2.0, z0], [0, corner_r, z0 + slot]),
]);
body - cutter
