// Bonded engine / subframe mount bushing (sleeves and rubber as one body): 50 mm outer sleeve 40 mm long with a 58 mm flange, 20 mm inner sleeve 50 mm long, 12.2 mm bolt bore, two 100 degree kidney voids
let outer_d = 50.0; // [35.0, 80.0] Outer sleeve diameter (mm)
let length = 40.0; // [25.0, 70.0] Outer sleeve length (mm)
let inner_d = 20.0; // [14.0, 30.0] Inner sleeve diameter (mm)
let bolt_d = 12.2; // [8.2, 16.2] Bolt bore (mm)
let void_angle = 100.0; // [40.0, 140.0] Void angle (degrees)
const flange_extra = 4.0;
const sleeve_proud = 5.0;
let ro = outer_d / 2.0;
let ri = inner_d / 2.0;
let body = cylinder(ro, length) + cylinder(ro + flange_extra, 2.5);
let sleeve = cylinder([0, 0, -sleeve_proud], "Z", ri, length + 2.0 * sleeve_proud);
// voids sit between r = ri + 3 and r = ro - 4, centred on +Y and -Y
let v1 = ri + 3.0;
let v2 = ro - 4.0;
let ha = void_angle / 2.0 * PI() / 180.0;
let wedge_r = ro * 2.0;
let wedge = polygon([[0, 0], [wedge_r * (PI() / 2.0 - ha).cos(), wedge_r * (PI() / 2.0 - ha).sin()], [0, wedge_r], [-wedge_r * (PI() / 2.0 - ha).cos(), wedge_r * (PI() / 2.0 - ha).sin()]]);
let ring = cylinder([0, 0, -1.0], "Z", v2, length + 2.0) - cylinder([0, 0, -2.0], "Z", v1, length + 4.0);
let kidney = ring & wedge.to_face().extrude([0, 0, length + 4.0]).translate([0, 0, -2.0]);
let voids = [kidney, kidney.mirror("ZX")];
let bush = body + sleeve - compound(voids);
bush - cylinder([0, 0, -sleeve_proud - 1.0], "Z", bolt_d / 2.0, length + 2.0 * sleeve_proud + 2.0)
