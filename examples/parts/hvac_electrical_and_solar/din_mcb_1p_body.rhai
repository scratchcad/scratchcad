// Single-pole miniature circuit breaker case (18 mm DIN module): 17.6 mm wide, 90 mm tall, 45 mm front shoulder, 73 mm overall depth, TS35 clip channel, toggle window and two terminal screw ports
let width = 17.6; // [17.0, 36.0] Module width (mm)
let height = 90.0; // [80.0, 100.0] Case height (mm)
let depth = 73.0; // [60.0, 80.0] Overall depth (mm)
let shoulder = 45.0; // [40.0, 50.0] Front shoulder height (mm)
let base_d = depth - 20.0;
let sh = min(shoulder, height - 20.0);
let prof = polygon("YZ", [[-height / 2.0, 0], [height / 2.0, 0], [height / 2.0, base_d], [sh / 2.0, base_d], [sh / 2.0 - 2.0, depth], [-sh / 2.0 + 2.0, depth], [-sh / 2.0, base_d], [-height / 2.0, base_d]]);
let c = prof.to_face().extrude([width, 0, 0]);
c = c.fillet(1.0, "|X");
c -= box_from_corners([-1, -17.7, -1], [width + 1.0, 17.7, 7.6]);
c += box_from_corners([0, -17.7, 0.5], [width, -15.8, 1.6]);
c += box_from_corners([0, 15.8, 0.5], [width, 17.7, 1.6]);
c -= box_centered(width - 6.0, 14.0, 20.0).translate([width / 2.0, 0, depth]);
let toggle = box_centered(width - 7.0, 6.0, 22.0).translate([width / 2.0, 0, depth]).rotate([width / 2.0, 0, depth - 4.0], "X", -15.0);
c += toggle;
for s in [-1.0, 1.0] {
    c -= cylinder([width / 2.0, s * (height / 2.0 - 8.0), base_d - 15.0], "Z", 3.0, 20.0);
    c -= box_centered(width - 4.0, 8.0, 9.0).translate([width / 2.0, s * (height / 2.0 - 2.0), base_d - 22.0]);
}
c - box_centered(width + 2.0, 18.0, 1.0).translate([width / 2.0, -sh / 4.0 - 2.0, depth]).translate([0, 0, 0.3]).rotate_z(0.0)
