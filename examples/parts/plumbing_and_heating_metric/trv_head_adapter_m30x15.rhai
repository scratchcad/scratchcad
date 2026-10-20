// TRV head adapter, valve clamp to M30 x 1.5 head: 36 mm knurled clamp collar 8 mm tall with 26 mm bore, 10 mm M30x1.5 male spigot (ring-groove thread), split with M4 clamp screw
let collar_d = 36.0; // [32.0, 44.0] Collar diameter (mm)
let collar_h = 8.0; // [6.0, 12.0] Collar height (mm)
let valve_bore = 26.0; // [20.0, 27.0] Valve body bore (mm)
let thread_len = 10.0; // [6.0, 14.0] Thread length (mm)
let ribs = 24; // [12, 36] Number of grip ribs
const major = 30.0;
const pitch = 1.5;
let depth = pitch * 0.6;
let ri = valve_bore / 2.0;
let rc = collar_d / 2.0;
let rmaj = major / 2.0 - 0.1;
let rmin = rmaj - depth;
let turns = (thread_len / pitch).floor().to_int();
let pts = [[ri, 0, 0], [rc, 0, 0], [rc, 0, collar_h], [rmin, 0, collar_h]];
for k in 0..turns {
    let z = collar_h + k.to_float() * pitch;
    pts.push([rmaj, 0, z + pitch * 0.5]);
    pts.push([rmin, 0, z + pitch]);
}
let top = collar_h + turns.to_float() * pitch;
pts.push([ri, 0, top]);
let body = polygon(pts).to_face().revolve("Z", 360);
let cuts = [];
for k in 0..ribs {
    let a = k.to_float() * 360.0 / ribs.to_float();
    cuts.push(cylinder([rc + 0.4, 0, -1], "Z", 1.0, collar_h + 2.0).rotate_z(a));
}
let split = box_from_corners([-0.75, -rc - 1.0, -1], [0.75, -ri + 0.5, collar_h + 1.0]);
let screw = cylinder([-rc - 1.0, -(ri + rc) / 2.0, collar_h / 2.0], "X", 1.7, collar_d + 2.0);
body - fuse_all(cuts) - split - screw
