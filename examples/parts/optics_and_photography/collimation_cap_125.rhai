// 1.25 in collimation cap (sight tube cap): 31.6 mm plug 20 mm long, 38 mm flange 3 mm thick, 1.2 mm peep hole, 45 deg reflective cone inside
let plug_od = 31.6; // [31.5, 31.75] Plug diameter (mm)
let plug_length = 20.0; // [10.0, 30.0] Plug length (mm)
let flange_od = 38.0; // [34.0, 45.0] Flange diameter (mm)
let flange_thickness = 3.0; // [2.0, 5.0] Flange thickness (mm)
let peep_hole = 1.2; // [0.8, 3.0] Peep hole diameter (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let rp = plug_od / 2.0;
let cap = cylinder(rp, plug_length + 0.1).chamfer(0.5, "%CIRCLE and <Z") + cylinder([0, 0, plug_length], "Z", flange_od / 2.0, flange_thickness).fillet(0.8, "%CIRCLE and >Z");
// cavity: straight bore, then a 45 deg cone up to the peep hole, leaving 1 mm at the hole
let top = plug_length + flange_thickness;
let ri = rp - wall;
let zc = top - 1.0 - (ri - 0.6);
let cavity = polygon("XZ", [[0, -1.0], [ri, -1.0], [ri, zc], [0.6, top - 1.0], [0, top - 1.0]]).to_face().revolve("Z", 360);
cap = cap - cavity;
cap - cylinder([0, 0, top - 4.0], "Z", peep_hole / 2.0, 5.0)
