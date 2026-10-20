// 58 mm single-row omni wheel: two 3 mm hub plates with 8 roller bays, 8 barrel rollers 16 mm long on 2 mm axles, 6 mm D-shaft hub
let wheel_d = 58.0; // [40.0, 100.0] Outside diameter (mm)
let rollers = 8; // [6, 12] Number of rollers
let roller_d = 12.0; // [8.0, 20.0] Roller diameter at the middle (mm)
let shaft = 6.0; // [3.0, 8.0] Shaft diameter (mm)
const plate_t = 3.0;
const width = 14.0;
let ro = wheel_d / 2.0;
let rr = roller_d / 2.0;
let rc = ro - rr;
let n = rollers.to_float();
let seg = 2.0 * rc * (PI() / n).tan();
let rl = seg * 0.85;
let barrel = sketch("XZ").move_to(0.8, -rl / 2.0).hline_to(rr * 0.6).arc_to(rr, 0, rr * 0.6, rl / 2.0).hline_to(0.8).close().to_face().revolve("Z", 360);
let hub = cylinder([0, 0, -width / 2.0], "Z", rc - rr * 0.2, width);
let bays = [];
let rlist = [];
let axles = [];
for i in 0..rollers {
    let a = i.to_float() * 360.0 / n;
    bays.push(box_centered(rl + 1.6, roller_d + 4.0, width - 2.0 * plate_t + 0.4).translate([0, rc, 0]).rotate_z(a));
    rlist.push(barrel.rotate_y(90.0).translate([0, rc, 0]).rotate_z(a));
    axles.push(cylinder([-seg / 2.0, rc, 0], "X", 0.8, seg).rotate_z(a));
}
let h = hub - fuse_all(bays);
h = h + fuse_all(axles);
h -= cylinder([0, 0, -width], "Z", shaft / 2.0, 2.0 * width) - box_from_corners([shaft / 2.0 - 0.5, -shaft, -width], [shaft, shaft, width]);
for i in 0..4 { h -= cylinder([rc * 0.45, 0, -width], "Z", 4.0, 2.0 * width).rotate_z(i.to_float() * 90.0 + 45.0); }
compound([h] + rlist)
