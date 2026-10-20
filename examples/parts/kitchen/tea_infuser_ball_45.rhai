// Tea infuser ball: 45 mm sphere in two 0.6 mm hemispherical shells with 1.6 mm holes in rings, 1.5 mm lip where the halves meet, chain loop on top; shown 4 mm apart
let diameter = 45.0; // [30.0, 70.0] Ball diameter (mm)
let shell = 0.8; // [0.5, 1.5] Shell thickness (mm)
let hole_diameter = 1.6; // [1.0, 3.0] Hole diameter (mm)
let ring_count = 4; // [2, 6] Rings of holes per half
let gap = 4.0; // [0.0, 20.0] Display gap between halves (mm)
let r = diameter / 2.0;
let lower = box_centered(3.0 * r, 3.0 * r, 2.0 * r).translate([0, 0, -r]);
let half = (sphere(r) & lower) - sphere(r - shell);
// lip: a flat ring around the rim
half = half + (cylinder([0, 0, -1.5], "Z", r + 1.5, 1.5) - cylinder([0, 0, -2.0], "Z", r - shell - 0.01, 2.5));
// radial holes in rings between 15 and 75 deg below the rim, plus one at the pole
let holes = [cylinder([0, 0, -r - 1.0], "Z", hole_diameter / 2.0, shell + 2.0)];
for k in 0..ring_count {
    let lat = 18.0 + k.to_float() * 54.0 / (ring_count - 1).max(1).to_float();
    let rr = r * (lat * PI() / 180.0).cos();
    let n = (2.0 * PI() * rr / (hole_diameter * 2.6)).floor().to_int();
    for j in 0..n {
        // each hole only spans the shell, so the hole tools do not overlap one another
        let h = cylinder([-(r - shell - 1.0), 0, 0], "-X", hole_diameter / 2.0, shell + 2.0).rotate_y(-lat);
        holes.push(h.rotate_z(j.to_float() * 360.0 / n.to_float() + k.to_float() * 7.0));
    }
}
half = half - compound(holes);
let top = half.mirror("XY").translate([0, 0, gap]);
top = top + torus(3.5, 0.9).rotate_x(90.0).translate([0, 0, gap + r + 3.0]);
compound([half, top])
