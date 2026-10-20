// Glass ampoule snapper for 1 to 2 ml ampoules: 20 mm sleeve 28 mm long with a blind 11 mm bore 24 mm deep for the ampoule head and a 1.5 mm lead-in chamfer, and a 45 mm long 4 mm thick lever wing 14 mm wide along the side with a 6 mm rounded tip
let bore_d = 11.0; // [8.0, 14.0] Bore diameter (mm)
let bore_depth = 24.0; // [15.0, 30.0] Bore depth (mm)
let sleeve_d = 20.0; // [16.0, 26.0] Sleeve diameter (mm)
let lever_len = 45.0; // [30.0, 70.0] Lever length (mm)
const sleeve_len = 28.0;
const lever_t = 4.0;
const lever_w = 14.0;
let ro = max(sleeve_d / 2.0, bore_d / 2.0 + 2.5);
let depth = min(bore_depth, sleeve_len - 3.0);
let sleeve = cylinder(ro, sleeve_len);
let lever = box_from_corners([0, -lever_t / 2.0, 0], [ro + lever_len, lever_t / 2.0, lever_w]);
let lever = lever.fillet(6.0, lever.edges("|Y and >X"));
let body = sleeve + lever;
let body = body - cylinder([0, 0, sleeve_len - depth], "Z", bore_d / 2.0, depth + 1.0);
body.chamfer(1.5, body.edges("%CIRCLE and >Z").filter(|e| e.radius() < 8.0))
