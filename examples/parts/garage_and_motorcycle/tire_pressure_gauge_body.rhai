// Pencil tyre pressure gauge body: 15 mm barrel 115 mm long with 9 mm bore for the slide, 30 degree chuck head for Schrader valves, pocket clip
let barrel_d = 15.0; // [12.0, 20.0] Barrel diameter (mm)
let barrel_length = 115.0; // [80.0, 150.0] Barrel length (mm)
let bore_d = 9.0; // [6.0, 12.0] Slide bore (mm)
let head_angle = 30.0; // [0.0, 45.0] Chuck head angle (degrees)
let chuck_d = 8.0; // [7.0, 9.0] Valve socket diameter (mm)
const head_d = 17.0;
const head_len = 22.0;
let barrel = cylinder([0, 0, 0], "Z", barrel_d / 2.0, barrel_length) - cylinder([0, 0, 6.0], "Z", bore_d / 2.0, barrel_length);
let head = cylinder([0, 0, 0], "Z", head_d / 2.0, head_len) - cylinder([0, 0, -1.0], "Z", chuck_d / 2.0, 12.0) - cylinder([0, 0, -1.0], "Z", 1.0, head_len + 2.0);
head = head.chamfer(1.0, "<Z");
let neck = sphere([0, 0, 0], head_d / 2.0 + 0.3);
let tilted = head.translate([0, 0, -head_len]).rotate([0, 0, 0], "Y", 180.0 - head_angle);
let clip = box_from_corners([-2.0, barrel_d / 2.0 - 0.5, barrel_length - 40.0], [2.0, barrel_d / 2.0 + 1.5, barrel_length - 5.0]) + box_from_corners([-2.0, barrel_d / 2.0 - 0.5, barrel_length - 8.0], [2.0, barrel_d / 2.0 + 3.0, barrel_length - 4.0]);
let gauge = fuse_all([barrel, neck - cylinder([0, 0, -10.0], "Z", 1.0, 20.0), tilted, clip]);
gauge - cylinder([0, 0, -2.0], "Z", 1.0, 10.0)
