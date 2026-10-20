// Oil drain plug M14x1.5: 17 mm hex head 7 mm high, 22 mm integral flange 2 mm, 13 mm thread, 6 x 3 mm magnet pocket in the tip
let thread_d = 14.0; // [10.0, 20.0] Thread diameter (mm)
let pitch = 1.5; // [1.0, 2.0] Thread pitch (mm)
let thread_length = 13.0; // [8.0, 25.0] Thread length (mm)
let hex_af = 17.0; // [13.0, 24.0] Hex across flats (mm)
let head_height = 7.0; // [4.0, 12.0] Head height (mm)
let flange_d = 22.0; // [18.0, 30.0] Flange diameter (mm)
let magnet_d = 6.0; // [3.0, 8.0] Magnet pocket diameter (mm)
const flange_t = 2.0;
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let rc = hex_af / sqrt(3.0);
let hex_pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hex_pts.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(hex_pts).to_face().extrude([0, 0, head_height + 0.5]).chamfer(0.8, "<Z");
let z0 = head_height;
let zs = z0 + flange_t + 0.6;
let zt = z0 + flange_t + thread_length;
let turns = ((thread_length - 1.2) / pitch).floor().to_int();
let prof = [[0.0, z0], [flange_d / 2.0, z0], [flange_d / 2.0, z0 + flange_t], [r_minor, z0 + flange_t], [r_minor, zs]];
for i in 0..turns {
    let z = zs + i.to_float() * pitch;
    prof.push([r_major, z + pitch / 2.0]);
    prof.push([r_minor, z + pitch]);
}
prof.push([r_minor, zt - 0.6]);
prof.push([r_minor - 0.6, zt]);
prof.push([0.0, zt]);
let shank = polygon("XZ", prof).to_face().revolve("Z", 360);
let plug = head + shank;
plug - cylinder([0, 0, zt - 3.0], "Z", magnet_d / 2.0, 4.0)
