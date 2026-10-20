// Fixed-back cufflink: 16 mm round face 2 mm thick with a chamfered edge, 3 mm post 15 mm long, 16 x 4 x 3 mm whale-back toggle with rounded ends
let face_diameter = 16.0; // [10.0, 24.0] Face diameter (mm)
let face_thickness = 2.0; // [1.2, 4.0] Face thickness (mm)
let post_diameter = 3.0; // [2.0, 5.0] Post diameter (mm)
let post_length = 15.0; // [8.0, 20.0] Post length (mm)
let toggle_length = 16.0; // [10.0, 22.0] Toggle length (mm)
let face_disc = cylinder(face_diameter / 2.0, face_thickness).chamfer(min(0.6, face_thickness / 3.0), ">Z");
let post = cylinder([0, 0, -post_length], "Z", post_diameter / 2.0, post_length + 0.5);
let toggle = box_centered(toggle_length - 4.0, 4.0, 3.0) + cylinder([-(toggle_length - 4.0) / 2.0, 0, -1.5], "Z", 2.0, 3.0) + cylinder([(toggle_length - 4.0) / 2.0, 0, -1.5], "Z", 2.0, 3.0);
toggle = toggle.clean().fillet(0.8, ">Z").translate([0, 0, -post_length - 1.0]);
fuse_all([face_disc, post, toggle])
