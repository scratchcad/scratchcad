// Shepherd's hook tent peg: 4 mm steel wire, 180 mm long, 12 mm hook at the top, ground point
let length = 180.0; // [100.0, 300.0] Peg length (mm)
let wire_diameter = 4.0; // [2.5, 6.0] Wire diameter (mm)
let hook_diameter = 12.0; // [8.0, 20.0] Hook inside diameter (mm)
let r = wire_diameter / 2.0;
let hr = hook_diameter / 2.0 + r;
let tip = 3.0 * wire_diameter;
let top = length - hr - r;
let path = wire([line([0, 0, tip - 0.05], [0, 0, top]), arc([0, 0, top], [hr, 0, top + hr], [2.0 * hr, 0, top]),
                 line([2.0 * hr, 0, top], [2.0 * hr, 0, top - hr * 1.2])]);
let rod = circle([0, 0, tip - 0.05], [0, 0, 1], r).to_face().sweep(path);
fuse_all([rod, cone(0.3, r, tip)])
