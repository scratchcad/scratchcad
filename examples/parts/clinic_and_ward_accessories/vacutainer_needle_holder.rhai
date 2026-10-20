// Blood collection tube holder: 17 mm bore barrel 2 mm wall, 50 mm long, 40 x 12 mm finger flange at the open end and a 9 mm hub with a 6.4 mm bore for the multi-sample needle thread
let bore = 17.0; // [14.0, 20.0] Barrel bore (mm)
let length = 50.0; // [35.0, 70.0] Barrel length (mm)
let flange = 40.0; // [30.0, 50.0] Flange span (mm)
const wall = 2.0;
const hub_l = 8.0;
let ri = bore / 2.0;
let ro = ri + wall;
let body = face(polygon([[3.2, 0, 0], [4.5, 0, 0], [4.5, 0, hub_l - 1.0], [ro, 0, hub_l], [ro, 0, hub_l + length], [ri, 0, hub_l + length], [ri, 0, hub_l + wall], [3.2, 0, hub_l + wall]])).revolve("Z", 360);
let f = box_centered(flange, 12.0, 2.5);
f = f.fillet(5.0, f.edges("|Z"));
let f = f.translate([0, 0, hub_l + length - 1.25]) - cylinder([0, 0, hub_l + length - 5.0], "Z", ri, 10.0);
body + f
