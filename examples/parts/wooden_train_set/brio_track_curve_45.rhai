// Wooden train track, 45 degree curve on a 182 mm centre radius: 40 x 12 mm section, 2 grooves, peg and socket ends
let radius = 182.0; // [120.0, 250.0] Centre radius (mm)
let angle = 45.0; // [15.0, 90.0] Curve angle (degrees)
const w = 40.0;
const t = 12.0;
let ring = cylinder(radius + w / 2.0, t) - cylinder([0, 0, -1], "Z", radius - w / 2.0, t + 2.0);
let a = angle * PI() / 180.0;
let sector = polygon([[0, 0], [radius * 2.0, 0], [radius * 2.0 * a.cos(), radius * 2.0 * a.sin()]]).to_face().extrude([0, 0, t + 2.0]).translate([0, 0, -1.0]);
let arc = ring & sector;
let grooves = (cylinder([0, 0, t - 3.0], "Z", radius + 13.0, 4.0) - cylinder([0, 0, t - 4.0], "Z", radius + 7.0, 6.0)) + (cylinder([0, 0, t - 3.0], "Z", radius - 7.0, 4.0) - cylinder([0, 0, t - 4.0], "Z", radius - 13.0, 6.0));
let socket = cylinder([radius, 11.0, -1], "Z", 6.25, t + 2.0) + box_from_corners([radius - 3.5, -1, -1], [radius + 3.5, 7.0, t + 1.0]);
let peg = (cylinder([radius, -11.0, 0], "Z", 5.75, t) + box_from_corners([radius - 3.0, -7.0, 0], [radius + 3.0, 0.01, t])).rotate_z(angle);
arc - grooves - socket + peg
