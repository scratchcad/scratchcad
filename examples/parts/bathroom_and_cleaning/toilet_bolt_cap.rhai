// Toilet closet-bolt cap: 32 mm base flange, 24 mm domed cover 36 mm tall, 2 mm wall, snaps over a 1/4 in floor bolt and washer
let base_d = 32.0; // [26.0, 40.0] Flange diameter (mm)
let cap_d = 24.0; // [18.0, 30.0] Cover diameter (mm)
let height = 36.0; // [25.0, 45.0] Overall height (mm)
let wall = 2.0; // [1.2, 3.0] Wall thickness (mm)
let r = cap_d / 2.0;
let zc = height - r;
const c45 = 0.7071068;
let outer = sketch("XZ").move_to(0, 0).hline(base_d / 2.0).vline(2.0).hline_to(r).vline_to(zc).arc_to(r * c45, zc + r * c45, 0, height).close();
let ri = r - wall;
let inner = sketch("XZ").move_to(0, -1).hline(ri).vline_to(zc).arc_to(ri * c45, zc + ri * c45, 0, zc + ri).close();
outer.to_face().revolve("Z", 360) - inner.to_face().revolve("Z", 360)
