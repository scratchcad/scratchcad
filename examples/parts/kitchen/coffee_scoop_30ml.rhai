// Coffee scoop, 30 ml (two level tablespoons, about 10 g of ground coffee): 44 mm cylindrical cup 20 mm deep, 1.5 mm wall, 75 mm flat handle angled 10 deg, bag-clip notch
let capacity = 30.0; // [10.0, 60.0] Capacity (ml)
let cup_diameter = 44.0; // [30.0, 60.0] Cup inside diameter (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let handle_length = 75.0; // [40.0, 120.0] Handle length (mm)
let handle_angle = 10.0; // [0.0, 30.0] Handle rise (deg)
let ri = cup_diameter / 2.0;
let depth = capacity * 1000.0 / (PI() * ri * ri);
print(`cup depth ${depth} mm`);
let cup = cylinder([0, 0, -wall], "Z", ri + wall, depth + wall).fillet(2.0, "%CIRCLE and <Z") - cylinder(ri, depth + 1.0);
let handle = box_from_corners([0, -7.0, -3.0], [handle_length, 7.0, 0]).fillet(6.5, "|Z and >X");
handle -= box_from_corners([handle_length * 0.55, 6.0 - 3.0, -4.0], [handle_length * 0.55 + 1.5, 8.0, 1.0]);
handle = handle.rotate([0, 0, 0], "Y", -handle_angle).translate([ri + 0.4, 0, depth]);
cup + handle
