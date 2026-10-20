// Wall-mount hanging lug for a steel enclosure: 20 mm wide, 2.5 mm strip, 25 mm flange on the enclosure with two 5.5 mm holes on 12 mm, 6 mm joggle, 30 mm wall tab with an 8 mm / 4.5 mm keyhole slot
let width = 20.0; // [15.0, 30.0] Lug width (mm)
let joggle = 6.0; // [3.0, 12.0] Wall offset (mm)
let tab = 30.0; // [20.0, 50.0] Wall tab length (mm)
let t = 2.5; // [2.0, 4.0] Strip thickness (mm)
const flange = 25.0;
let ramp = joggle;
let x2 = flange + ramp;
let x3 = x2 + tab;
let side = polygon([
    [0, 0, 0], [flange + t * 0.4, 0, 0], [x2 + t * 0.4, 0, joggle], [x3, 0, joggle],
    [x3, 0, joggle + t], [x2 - t * 0.4, 0, joggle + t], [flange - t * 0.4, 0, t], [0, 0, t]]);
let lug = face(side).extrude([0, width, 0]);
let lug = lug.fillet(4.0, lug.edges("|Z and >X"));
let holes = [];
for x in [6.0, 18.0] { holes.push(cylinder([x, width / 2.0, -1.0], "Z", 2.75, t + 2.0)); }
let kx = x3 - 10.0;
let key = cylinder([kx, width / 2.0, joggle - 1.0], "Z", 4.0, t + 2.0)
    + box_from_corners([kx - 10.0, width / 2.0 - 2.25, joggle - 1.0], [kx, width / 2.0 + 2.25, joggle + t + 1.0])
    + cylinder([kx - 10.0, width / 2.0, joggle - 1.0], "Z", 2.25, t + 2.0);
lug - fuse_all(holes) - key
