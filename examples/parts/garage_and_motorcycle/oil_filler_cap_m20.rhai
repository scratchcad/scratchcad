// Motorcycle engine oil filler cap M20x2.5: 32 mm head 12 mm tall with 8 grip lobes, O-ring groove under the head, 14 mm thread, 8 mm hex socket in the top
let head_d = 32.0; // [26.0, 40.0] Head diameter (mm)
let head_height = 12.0; // [8.0, 16.0] Head height (mm)
let lobes = 8; // [5, 12] Number of grip lobes
let thread_d = 20.0; // [16.0, 24.0] Thread diameter (mm)
let pitch = 2.5; // [1.5, 3.0] Thread pitch (mm)
let thread_length = 14.0; // [8.0, 20.0] Thread length (mm)
const socket_af = 8.0;
let r = head_d / 2.0;
let head = cylinder(r, head_height).fillet(1.5, ">Z");
let scallops = [];
for i in 0..lobes {
    let a = (i.to_float() + 0.5) * 2.0 * PI() / lobes.to_float();
    scallops.push(cylinder([(r + 2.2) * a.cos(), (r + 2.2) * a.sin(), -1.0], "Z", 4.0, head_height + 2.0));
}
head = head - compound(scallops);
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let prof = [[0.0, 0.5], [r_major - 0.6, 0.5], [r_major - 0.6, -3.0], [r_minor, -3.0], [r_minor, -3.5]];
let turns = ((thread_length - 4.5) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([r_major, -3.5 - (i.to_float() + 0.5) * pitch]);
    prof.push([r_minor, -3.5 - (i.to_float() + 1.0) * pitch]);
}
prof.push([r_minor, -thread_length + 0.8]);
prof.push([r_minor - 0.8, -thread_length]);
prof.push([0.0, -thread_length]);
let shank = polygon("XZ", prof).to_face().revolve("Z", 360);
shank = shank - (cylinder([0, 0, -2.6], "Z", r_major, 2.0) - cylinder([0, 0, -3.0], "Z", r_major - 2.2, 3.0));
let rc = socket_af / sqrt(3.0);
let hex = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; hex.push([rc * a.cos(), rc * a.sin()]); }
(head + shank) - polygon(hex).to_face().extrude([0, 0, 7.0]).translate([0, 0, head_height - 6.0])
