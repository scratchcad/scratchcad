// Vortex mixer cup head: 40 mm cup 22 mm tall with a 10 mm deep conical recess for tube bottoms, 6 mm D-shaft bore (5.5 mm across the flat) for the eccentric drive, 6 grip ribs
let cup_d = 40.0; // [25.0, 60.0] Cup diameter (mm)
let height = 22.0; // [16.0, 35.0] Cup height (mm)
let recess = 10.0; // [5.0, 14.0] Recess depth (mm)
let shaft = 6.0; // [4.0, 8.0] Drive shaft diameter (mm)
const ribs = 6;
let r = cup_d / 2.0;
let rd = min(recess, height - 8.0);
let cup = cylinder(r, height).chamfer(1.5, ">Z");
cup = cup - cone(2.0, r - 3.0, rd + 0.01).translate([0, 0, height - rd]);
let rib_list = [];
for k in 0..ribs {
    rib_list.push(box_centered(4.0, 2.0, height - 6.0).translate([r, 0, (height - 6.0) / 2.0 + 1.0]).rotate_z(k.to_float() * 360.0 / ribs.to_float()));
}
cup = cup + fuse_all(rib_list);
let bore = cylinder([0, 0, -1], "Z", shaft / 2.0, height - rd - 2.0) & box_centered(shaft + 2.0, shaft * 0.92, 2.0 * height).translate([0, -shaft * 0.04, 0]);
cup - bore
