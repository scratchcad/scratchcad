// Chafing dish fuel can holder: cup ring for a 67 mm gel fuel can, 2 mm wall, 22 mm tall, 50 mm opening in the base lip, and two 15 mm hanging tabs slotted for the stand's 6 mm wire frame
let can_d = 67.0; // [55.0, 80.0] Fuel can diameter (mm)
let height = 22.0; // [15.0, 35.0] Holder height (mm)
let wire = 6.0; // [4.0, 8.0] Frame wire diameter (mm)
const wall = 2.0;
const lip = 8.0;
let ri = can_d / 2.0 + 0.5;
let ro = ri + wall;
let cup = face(polygon([[ri - lip, 0, 0], [ro, 0, 0], [ro, 0, height], [ri, 0, height], [ri, 0, wall], [ri - lip, 0, wall]])).revolve("Z", 360);
let tabs = [];
let slots = [];
for sx in [-1.0, 1.0] {
    tabs.push(box_from_corners([sx * (ro - 1.0), -10.0, height - 3.0], [sx * (ro + 15.0), 10.0, height]));
    slots.push(box_from_corners([sx * (ro + 4.0), -wire / 2.0 - 0.3, height - 4.0], [sx * (ro + 16.0), wire / 2.0 + 0.3, height + 1.0]));
}
cup + fuse_all(tabs) - compound(slots)
