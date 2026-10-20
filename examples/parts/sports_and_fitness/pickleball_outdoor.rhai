// Outdoor pickleball: 74 mm ball, 3 mm seamless wall, 40 evenly spaced 8 mm holes
let diameter = 74.0; // [70.0, 76.0] Ball diameter (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
let holes = 40; // [26, 40] Number of holes
let hole_d = 8.0; // [6.0, 11.0] Hole diameter (mm)
let r = diameter / 2.0;
let ball = sphere(r) - sphere(r - wall);
let golden = PI() * (3.0 - sqrt(5.0));
let cutters = [];
for i in 0..holes {
    let z = 1.0 - 2.0 * (i.to_float() + 0.5) / holes.to_float();
    let rr = sqrt(1.0 - z * z);
    let th = golden * i.to_float();
    let d = [rr * th.cos(), rr * th.sin(), z];
    let start = [d[0] * (r - wall - 1.0), d[1] * (r - wall - 1.0), d[2] * (r - wall - 1.0)];
    cutters.push(cylinder(start, d, hole_d / 2.0, wall + 2.0));
}
ball - compound(cutters)
