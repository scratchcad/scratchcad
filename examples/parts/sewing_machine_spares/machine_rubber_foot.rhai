// Sewing machine base rubber foot: 16 mm foot 6 mm tall with a 1 mm bottom chamfer and 0.6 mm top chamfer, 4 mm push-in stud 6 mm long with a 5 mm barb cone that snaps into a 4.2 mm hole
let foot_d = 16.0; // [10.0, 25.0] Foot diameter (mm)
let foot_h = 6.0; // [3.0, 10.0] Foot height (mm)
let stud_d = 4.0; // [3.0, 5.0] Stud diameter (mm)
let stud_len = 6.0; // [4.0, 10.0] Stud length (mm)
const barb = 0.5;
let r = foot_d / 2.0;
let rs = stud_d / 2.0;
let h = foot_h + stud_len;
let profile = polygon([
    [0, 0, 0], [r - 1.0, 0, 0], [r, 0, 1.0], [r, 0, foot_h - 0.6], [r - 0.6, 0, foot_h],
    [rs, 0, foot_h], [rs, 0, h - 3.0], [rs + barb, 0, h - 3.0], [rs - 0.5, 0, h], [0, 0, h]
]);
profile.to_face().revolve("Z", 360.0)
