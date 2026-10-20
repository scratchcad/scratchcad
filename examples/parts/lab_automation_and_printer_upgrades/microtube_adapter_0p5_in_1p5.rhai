// Centrifuge adapter sleeve that holds a 0.5 ml tube in a 1.5 ml rotor bore: outside of a 1.5 ml tube (10.8 mm x 20 mm body, 18 mm cone to 4 mm, 12.5 mm collar 1.5 mm), inside 8.0 mm bore 17 mm with a 13 mm cone for the 0.5 ml tube
let outer_d = 10.8; // [10.0, 11.5] Sleeve outside diameter (mm)
let body_l = 20.0; // [15.0, 25.0] Straight body length (mm)
let cone_l = 18.0; // [12.0, 22.0] Outer cone length (mm)
let inner_d = 8.0; // [6.0, 8.6] Inner bore for the small tube (mm)
let collar_d = 12.5; // [11.6, 14.0] Collar diameter (mm)
const collar_t = 1.5;
const tip_r = 2.0;
let ro = outer_d / 2.0;
let ri = min(inner_d / 2.0, ro - 0.8);
let z_body = cone_l;
let z_top = cone_l + body_l;
// the inner cone starts 4 mm above the tip and ends just above the outer one, so the wall never gets thin
const zi = 4.0;
let zi_cyl = z_body + 1.0;
let prof = polygon([
    [0, 0, 0], [tip_r, 0, 0], [ro, 0, z_body], [ro, 0, z_top], [collar_d / 2.0, 0, z_top], [collar_d / 2.0, 0, z_top + collar_t],
    [ri, 0, z_top + collar_t], [ri, 0, zi_cyl], [1.0, 0, zi], [0, 0, zi]]);
prof.to_face().revolve("Z", 360)
