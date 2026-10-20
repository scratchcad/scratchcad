// Basin waste backnut 1 1/4 in BSP (G1 1/4, 41.9 mm major, 11 TPI): 56 mm ribbed plastic nut 14 mm tall, 8 wing ribs, ring-groove female thread, 3 mm sealing face
let thread_major = 41.9; // [33.2, 48.0] Thread major diameter (mm)
let outer_d = 56.0; // [46.0, 70.0] Nut diameter (mm)
let height = 14.0; // [10.0, 20.0] Nut height (mm)
let wings = 8; // [4, 12] Number of wing ribs
const pitch = 2.309;
let rmaj = thread_major / 2.0 + 0.15;
let rmin = rmaj - pitch * 0.64;
let ro = max(outer_d / 2.0 - 4.0, rmaj + 3.0);
let ring = cylinder(ro, height);
let ring = ring.chamfer(1.0, ring.edges());
let shapes = [ring];
for k in 0..wings {
    let w = box_from_corners([ro - 1.0, -2.0, 1.0], [ro + 4.0, 2.0, height - 1.0]);
    shapes.push(w.fillet(1.0, w.edges("|Z and >X")).rotate_z(k.to_float() * 360.0 / wings.to_float()));
}
let turns = ((height + 2.0) / pitch).floor().to_int() + 1;
let tp = [[0, 0, -1], [rmin, 0, -1]];
for k in 0..turns {
    let z = k.to_float() * pitch - 1.0;
    tp.push([rmaj, 0, z + pitch * 0.5]);
    tp.push([rmin, 0, z + pitch]);
}
tp.push([0, 0, turns.to_float() * pitch - 1.0]);
fuse_all(shapes) - polygon(tp).to_face().revolve("Z", 360)
