// 8-sided die: regular octahedron 18 mm across the faces with slightly rounded tips, from four slabs
let across = 18.0; // [10.0, 35.0] Distance across faces (mm)
let die = sphere(across * 0.85);
for n in [[1, 1, 1], [1, 1, -1], [1, -1, 1], [-1, 1, 1]] {
    let v = vec3(n[0].to_float(), n[1].to_float(), n[2].to_float()).normalize();
    let axis = vec3(0.0, 0.0, 1.0).cross(v);
    die = die & box_centered(4.0 * across, 4.0 * across, across).rotate(axis, v.z.acos() * 180.0 / PI());
}
die
