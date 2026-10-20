// Wheelchair cup holder: 80 mm ID cup ring 50 mm tall with 3 mm wall, 4 mm slotted floor, on a split clamp for a 22 to 25 mm armrest tube with an M6 thumbscrew boss, 30 mm offset arm
// # Cup
let cup_id = 80.0; // [65.0, 100.0] Cup inner diameter (mm)
let cup_height = 50.0; // [35.0, 80.0] Cup height (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
// # Clamp
let tube = 25.0; // [19.0, 32.0] Armrest tube diameter (mm)
let offset = 30.0; // [15.0, 50.0] Arm length to the tube (mm)
let ro = cup_id / 2.0 + wall;
let cup = cylinder(ro, cup_height) - cylinder([0, 0, 4.0], "Z", cup_id / 2.0, cup_height);
let drains = [box_centered(cup_id * 0.6, 4.0, 10.0), box_centered(4.0, cup_id * 0.6, 10.0)];
let cup2 = cup - fuse_all(drains);
let cx = ro + offset + tube / 2.0;
let arm = box_from_corners([ro - 3.0, -8.0, cup_height - 30.0], [cx, 8.0, cup_height]);
let clamp = cylinder([cx, 0, cup_height - 30.0], "Z", tube / 2.0 + 5.0, 30.0);
let boss = box_from_corners([cx + tube / 2.0 - 1.0, -7.0, cup_height - 30.0], [cx + tube / 2.0 + 14.0, 7.0, cup_height]);
let body = cup2 + arm + clamp + boss;
let bore = cylinder([cx, 0, cup_height - 31.0], "Z", tube / 2.0, 32.0);
let slit = box_from_corners([cx + tube / 2.0 - 2.0, -1.0, cup_height - 31.0], [cx + tube / 2.0 + 15.0, 1.0, cup_height + 1.0]);
let screw = cylinder([cx + tube / 2.0 + 8.0, -10.0, cup_height - 15.0], "Y", 3.1, 20.0);
body - bore - slit - screw - cylinder([0, 0, 4.0], "Z", cup_id / 2.0, cup_height)
