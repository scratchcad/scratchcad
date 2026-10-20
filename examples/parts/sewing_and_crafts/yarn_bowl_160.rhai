// Yarn bowl: 160 mm across, 100 mm tall, 5 mm wall, spiral feed slot and 12 mm yarn hole
let diameter = 160.0; // [120.0, 200.0] Bowl diameter (mm)
let height = 100.0; // [70.0, 130.0] Height (mm)
let wall = 5.0; // [3.0, 8.0] Wall (mm)
let r = diameter / 2.0;
let profile = sketch("XZ").move_to(0, 0).hline_to(r * 0.55).arc_to(r * 0.98, height * 0.45, r * 0.86, height).hline_to(r * 0.86 - wall).arc_to(r * 0.98 - wall, height * 0.45, r * 0.55 - wall * 0.3, wall).hline_to(0).close();
let bowl = profile.face().revolve("Z", 360);
let slot = box_from_corners([-4.0, r * 0.86 - 20.0, height * 0.55], [4.0, r + 10.0, height + 1.0]).rotate_z(-20.0) + box_from_corners([-4.0, r * 0.86 - 20.0, height * 0.55], [16.0, r + 10.0, height * 0.55 + 8.0]).rotate_z(-20.0);
let hole = cylinder([0, r * 0.86 - 20.0, height * 0.55 + 4.0], "Y", 6.0, 40.0).rotate_z(-20.0);
bowl - slot - hole
