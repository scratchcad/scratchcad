// 12-sided die: regular dodecahedron 20 mm across the faces from six slabs normal to the icosahedron vertex directions
let across = 20.0; // [12.0, 40.0] Distance across faces (mm)
let phi = (1.0 + sqrt(5.0)) / 2.0;
let die = sphere(across);
for n in [[0, 1, phi], [0, 1, -phi], [1, phi, 0], [-1, phi, 0], [phi, 0, 1], [-phi, 0, 1]] {
    let v = vec3(n[0].to_float(), n[1].to_float(), n[2].to_float()).normalize();
    let axis = vec3(0.0, 0.0, 1.0).cross(v);
    let slab = box_centered(4.0 * across, 4.0 * across, across);
    if axis.length() > 1e-9 { slab = slab.rotate(axis, v.z.acos() * 180.0 / PI()); }
    die = die & slab;
}
die
