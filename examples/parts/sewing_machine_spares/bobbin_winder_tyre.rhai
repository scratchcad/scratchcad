// Bobbin winder rubber tyre: 19 mm outside, 13 mm inside to stretch onto the winder pulley, 4 mm wide, 0.5 mm chamfers on the outer edges
let outer_d = 19.0; // [15.0, 26.0] Outside diameter (mm)
let inner_d = 13.0; // [9.0, 18.0] Inside diameter (mm)
let width = 4.0; // [3.0, 6.0] Tyre width (mm)
const ch = 0.5;
let ro = outer_d / 2.0;
let ri = min(inner_d / 2.0, ro - 2.0);
let profile = polygon([[ri, 0, 0], [ro - ch, 0, 0], [ro, 0, ch], [ro, 0, width - ch], [ro - ch, 0, width], [ri, 0, width]]);
profile.to_face().revolve("Z", 360.0)
