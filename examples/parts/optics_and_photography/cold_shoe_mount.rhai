// Cold-shoe to 1/4-20 adapter, ISO 518 foot: 18.6 x 18 mm foot 2 mm thick, 12 mm neck 3 mm tall, 16 mm round body 8 mm tall with a 1/4-20 stud 6 mm long on top
let foot_width = 18.6; // [17.0, 19.0] Foot width (mm)
let foot_length = 18.0; // [14.0, 20.0] Foot length (mm)
let foot_thickness = 2.0; // [1.5, 2.2] Foot thickness (mm)
let body_height = 8.0; // [4.0, 20.0] Body height (mm)
let stud_length = 6.0; // [4.0, 12.0] Stud length (mm)
let foot = box_centered(foot_width, foot_length, foot_thickness).translate([0, 0, foot_thickness / 2.0]).chamfer(0.4, "|Z or <Z");
let neck = box_centered(12.0, foot_length, 3.1).translate([0, 0, foot_thickness + 1.5]);
let body = cylinder([0, 0, foot_thickness + 3.0], "Z", 8.0, body_height).chamfer(0.6, "%CIRCLE and >Z");
let stud = cylinder([0, 0, foot_thickness + 3.0 + body_height - 0.1], "Z", 3.1, stud_length + 0.1).chamfer(0.5, "%CIRCLE and >Z");
// grip flats on the body
let part = fuse_all([foot, neck, body, stud]);
for s in [-1.0, 1.0] {
    part -= box_centered(4.0, 20.0, body_height - 1.6).translate([s * 9.0, 0, foot_thickness + 3.0 + body_height / 2.0 - 0.8 + 0.8]);
}
part
