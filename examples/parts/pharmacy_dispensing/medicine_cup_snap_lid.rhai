// Snap lid for 30 ml medicine cups: 47 mm disc 1.2 mm thick with a 1 mm skirt 5 mm deep gripping the 44.5 mm cup rim, a 0.6 mm inner bead at the skirt mouth, a 1 mm locating ring 3 mm inside the rim, and a 10 x 8 mm lift tab
let rim_d = 44.5; // [35.0, 60.0] Cup rim diameter (mm)
let skirt_h = 5.0; // [3.0, 8.0] Skirt depth (mm)
let top_t = 1.2; // [0.8, 2.0] Lid thickness (mm)
let tab_len = 10.0; // [6.0, 15.0] Tab length (mm)
const skirt_t = 1.0;
const bead = 0.6;
let ri = rim_d / 2.0 + 0.2;
let ro = ri + skirt_t;
let h = top_t + skirt_h;
let profile = polygon([
    [0, 0, h], [ro, 0, h], [ro, 0, 0], [ri - bead, 0, 0], [ri - bead, 0, 0.8], [ri, 0, 1.6],
    [ri, 0, skirt_h], [ri - 3.0, 0, skirt_h], [ri - 3.0, 0, skirt_h - 2.0], [ri - 4.0, 0, skirt_h - 2.0],
    [ri - 4.0, 0, skirt_h], [0, 0, skirt_h],
]);
let lid = profile.to_face().revolve("Z", 360.0);
let tab = box_from_corners([ro - 1.0, -4.0, h - top_t], [ro + tab_len, 4.0, h]);
let tab = tab.fillet(3.0, tab.edges("|Z and >X"));
lid + tab
