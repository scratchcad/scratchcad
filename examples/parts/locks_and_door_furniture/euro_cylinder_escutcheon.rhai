// Euro profile cylinder escutcheon: 52 mm rosette 8 mm thick with a 1 mm edge chamfer and a euro keyhole cut-out (17 mm round top, 10 mm wide foot, 33 mm overall), two 4 mm fixing holes at 38 mm centres
let dia = 52.0; // [45.0, 60.0] Rosette diameter (mm)
let t = 8.0; // [5.0, 12.0] Rosette thickness (mm)
const clr = 0.5;
let r = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let r = r.chamfer(1.0, r.edges(">Z"));
let cut = cylinder([0, 8.0, -1.0], "Z", 8.5 + clr, t + 2.0) + box_from_corners([-5.0 - clr, -25.0 + 8.5 - clr, -1.0], [5.0 + clr, 8.0, t + 1.0]);
let fix = cylinder([-19.0, 0, -1.0], "Z", 2.0, t + 2.0) + cylinder([19.0, 0, -1.0], "Z", 2.0, t + 2.0);
r - cut - fix
