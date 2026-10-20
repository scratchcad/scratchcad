// Fork seal driver half for 43 mm fork tubes: split collar 43.5 mm bore, 56 mm OD driving face 70 mm long, 62 mm grip band, one of two halves
let tube_d = 43.0; // [35.0, 55.0] Fork tube diameter (mm)
let face_d = 56.0; // [45.0, 70.0] Driving face diameter (mm)
let length = 70.0; // [40.0, 100.0] Length (mm)
let grip_d = 62.0; // [50.0, 80.0] Grip band diameter (mm)
const clearance = 0.5;
let ri = (tube_d + clearance) / 2.0;
let ro = max(face_d / 2.0, ri + 4.0);
let rg = max(grip_d / 2.0, ro + 2.0);
let prof = sketch("XZ").move_to(ri, 0).hline_to(ro).vline_to(length * 0.4).hline_to(rg).vline_to(length - 3.0).line_to(rg - 3.0, length).hline_to(ri).close();
let collar = prof.to_face().revolve("Z", 360);
let half = collar - box_from_corners([-rg - 1.0, -rg - 1.0, -1.0], [rg + 1.0, 0.25, length + 1.0]);
half - cylinder([0, 0, length * 0.7], "Y", 4.0, rg + 2.0)
