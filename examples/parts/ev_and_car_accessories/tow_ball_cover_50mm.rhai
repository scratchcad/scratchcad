// Tow ball cover for a 50 mm (ISO 1103) ball: dome 2 mm wall, 50.6 mm cavity, 46 mm snap lip 14 mm below the ball centre, skirt to 22 mm below centre, 6 flex slots, finger loop on top
let ball = 50.0; // [45.0, 52.0] Ball diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let lip_d = 46.0; // [40.0, 48.0] Snap lip opening (mm)
let skirt = 22.0; // [16.0, 30.0] Skirt depth below the ball centre (mm)
let slots = 6; // [3, 10] Number of flex slots

const lip_z = -14.0;
let ri = ball / 2.0 + 0.3;
let ro = ri + wall;
let outer = (sphere([0, 0, 0], ro) & box_from_corners([-ro - 1.0, -ro - 1.0, 0], [ro + 1.0, ro + 1.0, ro + 1.0])) + cylinder([0, 0, -skirt], "Z", ro, skirt);
let cavity = sphere([0, 0, 0], ri) + cylinder([0, 0, lip_z + 2.0], "Z", ri, -lip_z - 2.0);
let opening = cylinder([0, 0, -skirt - 1.0], "Z", min(lip_d, ball - 2.0) / 2.0, skirt + lip_z + 3.0);
let cover = outer - cavity - opening;
let cuts = [];
for i in 0..slots {
    cuts.push(box_from_corners([0, -0.75, -skirt - 1.0], [ro + 2.0, 0.75, lip_z + 6.0]).rotate_z(i * 360.0 / slots));
}
cover = cover - fuse_all(cuts);
let loop_ring = cylinder([0, -2.5, ro + 6.0], "Y", 8.0, 5.0) - cylinder([0, -3.5, ro + 6.0], "Y", 4.5, 7.0);
let post = box_from_corners([-5.0, -2.5, ro - 2.0], [5.0, 2.5, ro + 3.0]);
cover + (loop_ring + post)
