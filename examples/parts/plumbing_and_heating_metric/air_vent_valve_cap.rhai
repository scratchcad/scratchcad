// Automatic air vent (AAV) screw cap for 3/8 in boiler vents: 18 mm knurled cap 12 mm tall, 12 grip ribs, 14 mm M14x1 bore 9 mm deep (ring-groove thread), 1.5 mm vent hole
let diameter = 18.0; // [14.0, 26.0] Cap diameter (mm)
let height = 12.0; // [8.0, 18.0] Cap height (mm)
let bore = 14.0; // [10.0, 20.0] Thread size (mm)
let thread_depth = 9.0; // [5.0, 14.0] Thread depth (mm)
let ribs = 12; // [6, 24] Number of grip ribs
const pitch = 1.0;
let r = max(diameter / 2.0, bore / 2.0 + 2.0);
let rmaj = bore / 2.0 + 0.05;
let rmin = rmaj - 0.55;
let td = min(thread_depth, height - 2.0);
let cap = cylinder(r, height);
let cap = cap.chamfer(0.8, cap.edges(">Z"));
let tp = [[0, 0, -1], [rmin, 0, -1]];
let turns = (td / pitch).floor().to_int();
for k in 0..turns {
    let z = k.to_float() * pitch - 1.0;
    tp.push([rmaj, 0, z + pitch * 0.5]);
    tp.push([rmin, 0, z + pitch]);
}
tp.push([0, 0, turns.to_float() * pitch - 1.0]);
let thread_cut = polygon(tp).to_face().revolve("Z", 360);
let cuts = [];
for k in 0..ribs {
    let a = k.to_float() * 360.0 / ribs.to_float();
    cuts.push(box_centered(1.2, 1.2, height * 2.0).rotate_z(45.0).translate([r, 0, 0]).rotate_z(a));
}
cap - thread_cut - fuse_all(cuts) - cylinder([0, 0, 0], "Z", 0.75, height + 1.0)
