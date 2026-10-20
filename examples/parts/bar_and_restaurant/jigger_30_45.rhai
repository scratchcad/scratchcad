// Double bar jigger 30 / 45 ml: two cones on a 20 mm waist, 1.2 mm wall, 50 mm rims
let rim = 50.0; // [35.0, 60.0] Rim diameter (mm)
let small_h = 35.0; // [20.0, 45.0] 30 ml cup height (mm)
let large_h = 52.0; // [30.0, 55.0] 45 ml cup height (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let waist = 20.0; // [10.0, 25.0] Waist diameter (mm)
let a = cone(waist / 2.0, rim / 2.0, small_h).translate([0, 0, 3.0]) - cone(waist / 2.0 - wall, rim / 2.0 - wall, small_h).translate([0, 0, 3.0 + wall]);
let b = (cone(waist / 2.0, rim / 2.0, large_h) - cone(waist / 2.0 - wall, rim / 2.0 - wall, large_h).translate([0, 0, wall])).rotate_x(180.0);
let w = cylinder(waist / 2.0, 3.01);
let cup30 = cone(waist / 2.0 - wall, rim / 2.0 - wall, small_h - wall);
let cup45 = cone(waist / 2.0 - wall, rim / 2.0 - wall, large_h - wall);
print(`capacities: ${cup30.volume() / 1000.0} ml and ${cup45.volume() / 1000.0} ml`);
a + w + b
