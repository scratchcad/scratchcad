// Motorcycle mirror riser / extender M10x1.25: 17 mm hex body 40 mm long, M10 male stud 14 mm, M10 tapped socket 15 mm deep, 17 mm M10 jam nut seat face
let hex_af = 17.0; // [14.0, 22.0] Hex across flats (mm)
let body_length = 40.0; // [20.0, 80.0] Body length (mm)
let stud_length = 14.0; // [10.0, 20.0] Stud length (mm)
let socket_depth = 15.0; // [10.0, 20.0] Socket depth (mm)
let thread_d = 10.0; // [8.0, 12.0] Thread size (mm)
let pitch = 1.25; // [1.0, 1.75] Thread pitch (mm)
let rc = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = polygon(pts).to_face().extrude([0, 0, body_length]).chamfer(0.8, ">Z or <Z");
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let prof = [[0.0, -0.5], [r_minor, -0.5], [r_minor, 0.0]];
let turns = ((stud_length - 1.0) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([r_major, -(i.to_float() + 0.5) * pitch]);
    prof.push([r_minor, -(i.to_float() + 1.0) * pitch]);
}
prof.push([r_minor, -stud_length + 0.5]);
prof.push([r_minor - 0.5, -stud_length]);
prof.push([0.0, -stud_length]);
let stud = polygon("XZ", prof).to_face().revolve("Z", 360).translate([0, 0, 0.5]);
let ext = body + stud;
let tap = r_major - 1.08 * pitch;
ext - cylinder([0, 0, body_length - socket_depth], "Z", tap, socket_depth + 1.0) - cone(tap, r_major + 0.5, r_major + 0.5 - tap).translate([0, 0, body_length - (r_major + 0.5 - tap) + 0.01])
