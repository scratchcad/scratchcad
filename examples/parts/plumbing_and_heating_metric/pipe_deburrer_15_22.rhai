// Copper pipe deburring tool for 10 to 28 mm: 40 mm grip 45 mm long with 16 flutes, 90 degree outside-deburr cone recess 30 mm, 35 mm inside-reamer cone point, 3 blade slots 1 mm
let grip_d = 40.0; // [30.0, 50.0] Grip diameter (mm)
let grip_len = 45.0; // [30.0, 60.0] Grip length (mm)
let cone_len = 18.0; // [10.0, 25.0] Reamer cone length (mm)
let flutes = 16; // [0, 24] Number of grip flutes
let blades = 3; // [2, 6] Number of blade slots
let r = grip_d / 2.0;
let rr = min(15.0, r - 3.0);
let pts = [[0, 0, 0], [r - 1.0, 0, 0], [r, 0, 1.0], [r, 0, grip_len - 1.0], [r - 1.0, 0, grip_len], [rr, 0, grip_len], [2.0, 0, grip_len + cone_len], [0, 0, grip_len + cone_len]];
let body = polygon(pts).to_face().revolve("Z", 360);
let recess = polygon([[0, 0, -1], [r - 4.0, 0, -1], [0, 0, r - 5.0]]).to_face().revolve("Z", 360);
let cuts = [recess];
for k in 0..flutes {
    let a = k.to_float() * 360.0 / flutes.to_float();
    cuts.push(cylinder([r + 0.6, 0, 6.0], "Z", 1.5, grip_len - 12.0).rotate_z(a));
}
let slots = [];
for k in 0..blades {
    let a = k.to_float() * 360.0 / blades.to_float() + 15.0;
    slots.push(box_from_corners([1.0, -0.5, grip_len + 2.0], [rr + 1.0, 0.5, grip_len + cone_len - 2.0]).rotate_z(a));
    slots.push(box_from_corners([1.5, -0.5, -1], [r - 5.0, 0.5, r * 0.4]).rotate_z(a + 60.0));
}
body - fuse_all(cuts) - compound(slots)
