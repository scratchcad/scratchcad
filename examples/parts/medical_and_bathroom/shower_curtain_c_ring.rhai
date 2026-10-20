// C-shaped shower curtain ring: 40 mm inside diameter for rods up to 32 mm, 6 mm rod, 12 mm gap at the bottom with ball ends to catch the curtain eyelet
let inside_diameter = 40.0; // [30.0, 60.0] Inside diameter (mm)
let rod = 6.0; // [4.0, 9.0] Ring rod diameter (mm)
let gap_angle = 40.0; // [20.0, 70.0] Opening angle (degrees)
let r = rod / 2.0;
let R = inside_diameter / 2.0 + r;
let ring = torus(R, r).rotate_x(90.0);
let g = gap_angle * PI() / 180.0 / 2.0;
let wedge = polygon([[0, -10.0, 0], [-R * 2.0 * g.sin() / g.cos(), -10.0, -R * 2.0], [R * 2.0 * g.sin() / g.cos(), -10.0, -R * 2.0]]).to_face().extrude([0, 20.0, 0]);
ring -= wedge;
let parts = [ring];
for s in [-1.0, 1.0] {
    parts.push(sphere([s * R * g.sin(), 0, -R * g.cos()], r + 1.0));
}
fuse_all(parts)
