// 4-sided die: regular tetrahedron with 20 mm edges and truncated tips, standing on a face
let edge = 20.0; // [12.0, 40.0] Edge length (mm)
let r_in = edge / (2.0 * sqrt(6.0));
let die = sphere(edge * 0.55);
for n in [[1, 1, 1], [1, -1, -1], [-1, 1, -1], [-1, -1, 1]] {
    let v = vec3(n[0].to_float(), n[1].to_float(), n[2].to_float()).normalize();
    let axis = vec3(0.0, 0.0, 1.0).cross(v);
    die = die & box_centered(6.0 * edge, 6.0 * edge, 6.0 * edge).translate([0, 0, r_in - 3.0 * edge]).rotate(axis, v.z.acos() * 180.0 / PI());
}
die
