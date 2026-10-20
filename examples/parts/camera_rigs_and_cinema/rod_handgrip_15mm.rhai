// Handgrip for a 15 mm rod rig: 110 mm long octagonal grip 32 mm across flats with 2 mm chamfered ends, 15.1 mm rod bore through one end (split with a 1.5 mm slot and an M5 pinch hole, 5.3 mm) and an M6 tapped hole (5 mm core) at the bottom end for a lanyard screw
let length = 110.0; // [80.0, 150.0] Grip length (mm)
let grip = 32.0; // [26.0, 40.0] Grip size across flats (mm)
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let r = grip / 2.0 / cos(22.5 * PI() / 180.0);
let pts = [];
for i in 0..8 {
    let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let body = face(polygon(pts)).extrude([0, 0, length]);
let body = body.chamfer(2.0, body.edges(">Z or <Z"));
let zc = length - grip / 2.0 - 1.0;
let rod = cylinder([0, -grip, zc], "Y", rod_d / 2.0 + 0.05, 2.0 * grip);
let split = box_from_corners([-0.75, -grip, zc - rod_d / 2.0 - 12.0], [0.75, grip, zc]);
let pinch = cylinder([-grip, 0, zc - rod_d / 2.0 - 6.0], "X", 2.65, 2.0 * grip);
let tap = cylinder([0, 0, -1.0], "Z", 2.5, 13.0);
body - rod - split - pinch - tap
