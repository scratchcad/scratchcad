// 20-sided die: regular icosahedron 22 mm across the faces, made by intersecting ten slabs normal to the dodecahedron directions
let across = 22.0; // [12.0, 40.0] Distance across faces (mm)
let phi = (1.0 + sqrt(5.0)) / 2.0;
let normals = [[1, 1, 1], [1, 1, -1], [1, -1, 1], [-1, 1, 1], [0, 1.0 / phi, phi], [0, 1.0 / phi, -phi], [1.0 / phi, phi, 0], [-1.0 / phi, phi, 0], [phi, 0, 1.0 / phi], [-phi, 0, 1.0 / phi]];
let die = sphere(across);
for n in normals {
    let v = vec3(n[0].to_float(), n[1].to_float(), n[2].to_float()).normalize();
    let axis = vec3(0.0, 0.0, 1.0).cross(v);
    let slab = box_centered(4.0 * across, 4.0 * across, across);
    if axis.length() > 1e-9 { slab = slab.rotate(axis, v.z.acos() * 180.0 / PI()); }
    die = die & slab;
}
die
