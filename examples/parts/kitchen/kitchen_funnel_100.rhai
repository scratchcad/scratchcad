// Kitchen funnel: 100 mm mouth, 60 deg cone to a 14 mm spout 40 mm long with an angled tip, 1.5 mm wall, rolled rim and a hanging tab
let mouth_diameter = 100.0; // [60.0, 160.0] Mouth diameter (mm)
let spout_diameter = 14.0; // [8.0, 25.0] Spout outside diameter (mm)
let spout_length = 40.0; // [20.0, 80.0] Spout length (mm)
let cone_angle = 60.0; // [45.0, 75.0] Included cone angle (deg)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let rm = mouth_diameter / 2.0;
let rs = spout_diameter / 2.0;
let cone_h = (rm - rs) / (cone_angle / 2.0 * PI() / 180.0).tan();
let zt = spout_length + cone_h;
// outer and inner profiles revolved: spout below z = spout_length, cone above
let outer = polygon("XZ", [[0, -5.0], [rs, -5.0], [rs, spout_length], [rm, zt], [0, zt]]).to_face().revolve("Z", 360);
let inner = polygon("XZ", [[0, -6.0], [rs - wall, -6.0], [rs - wall, spout_length], [rm - wall * 1.15, zt + 0.01], [rm - wall * 1.15, zt + 1.0], [0, zt + 1.0]]).to_face().revolve("Z", 360);
let funnel = (outer - inner) + torus(rm - wall / 2.0, wall).translate([0, 0, zt]);
// angled spout tip and a hanging tab on the rim
funnel -= box_centered(40.0, 40.0, 20.0).rotate_y(30.0).translate([0, 0, -8.0]);
let tab = (box_from_corners([rm - 4.0, -8.0, zt - 1.5], [rm + 14.0, 8.0, zt]).fillet(7.0, "|Z and >X") - cylinder([rm + 7.0, 0, zt - 3.0], "Z", 3.5, 5.0));
funnel + tab
