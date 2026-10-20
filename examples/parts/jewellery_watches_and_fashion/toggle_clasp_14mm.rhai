// Toggle clasp, 14 mm ring with 9 mm opening and an 18 mm T-bar, both 1.5 mm thick with 4 mm attachment loops
let ring_diameter = 14.0; // [8.0, 24.0] Ring outer diameter (mm)
let ring_opening = 9.0; // [5.0, 18.0] Ring opening (mm)
let bar_length = 18.0; // [10.0, 30.0] Bar length (mm)
let thickness = 1.5; // [1.0, 3.0] Thickness (mm)
let loop_diameter = 4.0; // [2.5, 6.0] Loop outer diameter (mm)
let ro = ring_diameter / 2.0;
let ri = min(ring_opening / 2.0, ro - 1.0);
let rl = loop_diameter / 2.0;
let bl = max(bar_length, ring_opening + 3.0);
fn loop_at(x, y, rl, t) {
    cylinder([x, y, 0], "Z", rl, t) - cylinder([x, y, -1], "Z", rl * 0.5, t + 2.0)
}
let ring = cylinder(ro, thickness) - cylinder([0, 0, -1], "Z", ri, thickness + 2.0);
ring = ring + loop_at(ro + rl - 0.4, 0, rl, thickness);
// bar beside the ring, loop on its middle
let by = -(ro + rl + 4.0);
let bar = box_centered(bl - 2.0, 2.0, thickness).translate([0, by, thickness / 2.0]);
bar = bar + cylinder([-(bl - 2.0) / 2.0, by, 0], "Z", 1.0, thickness) + cylinder([(bl - 2.0) / 2.0, by, 0], "Z", 1.0, thickness);
bar = bar + loop_at(0, by - 1.0 - rl + 0.4, rl, thickness);
[ring, bar]
