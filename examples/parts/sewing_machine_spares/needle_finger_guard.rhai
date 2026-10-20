// Needle finger guard: 2 mm thick flat loop that clamps on the presser bar, 30 mm long U-shaped guard 22 mm wide made of a 4 mm strip round a 14 mm opening, closed by a 12 mm clamp tab across its full width with a 4.2 x 7 mm slot for the presser foot screw
let loop_len = 30.0; // [20.0, 45.0] Guard length (mm)
let loop_w = 22.0; // [16.0, 30.0] Guard width (mm)
let strip = 4.0; // [2.5, 5.0] Strip width (mm)
let thickness = 2.0; // [1.5, 3.0] Thickness (mm)
let outer = box_from_corners([0, -loop_w / 2.0, 0], [loop_len, loop_w / 2.0, thickness]);
let outer = outer.fillet(loop_w / 2.0 - 0.5, outer.edges("|Z and >X"));
let ri = loop_w / 2.0 - strip;
let inner = box_from_corners([-1.0, -ri, -1.0], [loop_len - strip, ri, thickness + 1.0]);
let inner = inner.fillet(ri - 0.3, inner.edges("|Z and >X"));
let tab = box_from_corners([-12.0, -loop_w / 2.0, 0], [0.5, loop_w / 2.0, thickness]);
let tab = tab.fillet(3.0, tab.edges("|Z and <X"));
let guard = (outer - inner) + tab;
guard - fuse_all([
    box_from_corners([-9.0 + 2.1, -2.1, -1.0], [-2.0 - 2.1, 2.1, thickness + 1.0]),
    cylinder([-9.0 + 2.1, 0, -1.0], "Z", 2.1, thickness + 2.0),
    cylinder([-2.0 - 2.1, 0, -1.0], "Z", 2.1, thickness + 2.0),
])
