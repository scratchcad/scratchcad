// Cabinet door hinge pin bush: flanged plastic bush for a 6 mm hinge pin, 10 mm OD body 12 mm long, 14 mm flange 1.5 mm thick, 0.5 mm lead-in chamfer at the bore
let pin_d = 6.0; // [4.0, 12.0] Pin diameter (mm)
let length = 12.0; // [6.0, 25.0] Body length (mm)
let flange_t = 1.5; // [1.0, 3.0] Flange thickness (mm)
let ri = pin_d / 2.0 + 0.05;
let ro = pin_d / 2.0 + 2.0;
let rf = pin_d / 2.0 + 4.0;
let h = flange_t + length;
let profile = polygon([
    [ri + 0.5, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [ro, 0, flange_t], [ro, 0, h - 0.4], [ro - 0.4, 0, h],
    [ri, 0, h], [ri, 0, 0.5]]);
face(profile).revolve("Z", 360.0)
