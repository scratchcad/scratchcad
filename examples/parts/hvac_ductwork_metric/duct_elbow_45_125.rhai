// Two-gore 45 degree duct elbow 125 mm: 124 mm OD, 1.5 mm wall, 80 mm legs measured on the centreline to the mitre, plain spigot ends with a 2 mm stop bead 30 mm in
let duct_d = 124.0; // [80.0, 250.0] Duct outside diameter (mm)
let angle = 45.0; // [15.0, 90.0] Bend angle (degrees)
let leg = 80.0; // [60.0, 160.0] Leg length (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let ro = duct_d / 2.0;
let half = angle / 2.0 * PI() / 180.0;
let reach = ro * half.sin() / half.cos() + 2.0;
let tube = cylinder([0, 0, -leg], "Z", ro, leg + reach) - cylinder([0, 0, -leg - 1.0], "Z", ro - wall, leg + reach + 2.0);
tube = tube + (cylinder([0, 0, -leg + 30.0], "Z", ro + 2.0, 3.0) - cylinder([0, 0, -leg + 29.0], "Z", ro - 1.0, 5.0));
// keep everything below the mitre plane, then mirror it across that plane for the second gore
let keep = box_centered(4.0 * ro, 4.0 * ro, 2.0 * (leg + reach)).translate([0, 0, -(leg + reach)]).rotate_y(angle / 2.0);
let gore = tube & keep;
let n = [half.sin(), 0.0, half.cos()];
gore + gore.mirror([0, 0, 0], n)
