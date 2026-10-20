// Screw-in towing eye: M18x2.5 thread 30 mm, 20 mm shank 60 mm, forged eye 50 mm outside / 28 mm inside, 14 mm thick with 3 mm rounds
let thread_d = 18.0; // [14.0, 24.0] Thread diameter (mm)
let pitch = 2.5; // [1.5, 3.0] Thread pitch (mm)
let thread_length = 30.0; // [20.0, 45.0] Thread length (mm)
let shank_d = 20.0; // [16.0, 26.0] Shank diameter (mm)
let shank_length = 60.0; // [30.0, 120.0] Shank length (mm)
let eye_od = 50.0; // [40.0, 70.0] Eye outside diameter (mm)
let eye_id = 28.0; // [20.0, 45.0] Eye inside diameter (mm)
const eye_t = 14.0;
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let prof = [[0.0, 0.0], [r_minor - 1.0, 0.0], [r_minor, 1.0]];
let turns = ((thread_length - 2.0) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([r_major, 1.0 + (i.to_float() + 0.5) * pitch]);
    prof.push([r_minor, 1.0 + (i.to_float() + 1.0) * pitch]);
}
prof.push([r_minor, thread_length + 0.5]);
prof.push([0.0, thread_length + 0.5]);
let threads = polygon("XZ", prof).to_face().revolve("Z", 360);
let shank = cylinder([0, 0, thread_length], "Z", shank_d / 2.0, shank_length).chamfer(1.0, "<Z");
let id = min(eye_id, eye_od - 12.0);
let eye_z = thread_length + shank_length + eye_od / 2.0 - 4.0;
let eye = (cylinder([0, -eye_t / 2.0, eye_z], "Y", eye_od / 2.0, eye_t) - cylinder([0, -eye_t, eye_z], "Y", id / 2.0, eye_t * 2.0)).fillet(3.0);
fuse_all([threads, shank, eye])
