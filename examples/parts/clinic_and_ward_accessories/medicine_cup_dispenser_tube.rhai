// Wall dispenser tube for 30 ml medicine cups: 47 mm bore, 2 mm wall, 200 mm long, a 3 mm inward lip at the bottom (41 mm opening) that holds the stack, a 15 mm viewing slot and two 4.5 mm screw tabs
let cup_rim = 45.0; // [35.0, 60.0] Cup rim diameter (mm)
let length = 200.0; // [120.0, 300.0] Tube length (mm)
let lip = 3.0; // [1.5, 5.0] Retaining lip width (mm)
const wall = 2.0;
let ri = cup_rim / 2.0 + 1.0;
let ro = ri + wall;
let tube = face(polygon([[ri - lip, 0, 0], [ro, 0, 0], [ro, 0, length], [ri, 0, length], [ri, 0, wall], [ri - lip, 0, wall]])).revolve("Z", 360);
tube = tube - box_from_corners([-7.5, ri - 1.0, 25.0], [7.5, ro + 1.0, length - 20.0]);
let tabs = [];
for z in [10.0, length - 25.0] {
    tabs.push(box_from_corners([-12.0, -ro - 2.0, z], [12.0, -ri + 0.5, z + 15.0]) - cylinder([0, -ro - 3.0, z + 7.5], "Y", 2.25, 4.0));
}
tube + fuse_all(tabs) - cylinder([0, 0, wall], "Z", ri, length)
