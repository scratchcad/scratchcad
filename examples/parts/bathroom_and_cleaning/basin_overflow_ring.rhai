// Basin overflow ring insert: 30 mm flange 2 mm thick, 22 mm opening, 8 mm sleeve with 3 snap tabs for a 24 mm overflow hole
let flange_d = 30.0; // [24.0, 40.0] Flange diameter (mm)
let hole_d = 24.0; // [18.0, 28.8] Overflow hole in the basin (mm)
let sleeve = 8.0; // [5.0, 12.0] Sleeve depth (mm)
let wall = 1.2; // [0.8, 2.0] Sleeve wall (mm)
let ro = hole_d / 2.0 - 0.2;
let ri = ro - wall;
let flange = cylinder(flange_d / 2.0, 2.0) - cylinder([0, 0, -1], "Z", ri, 4.0);
let f = flange.chamfer(0.6, flange.edges(">Z and %CIRCLE").sort_by(|e| -e.radius()).first());
let sl = cylinder([0, 0, -sleeve], "Z", ro, sleeve + 0.5) - cylinder([0, 0, -sleeve - 1.0], "Z", ri, sleeve + 2.0);
let tabs = [];
for i in 0..3 { tabs.push((cone(ro + 0.8, ro, 2.0).translate([0, 0, -sleeve + 0.5]) - cylinder([0, 0, -sleeve], "Z", ro - 0.3, 4.0)) & box_from_corners([-4.0, 0, -sleeve], [4.0, ro + 2.0, 0]).rotate_z(i.to_float() * 120.0)); }
f + sl + fuse_all(tabs)
