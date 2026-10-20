// KP08 zinc pillow block bearing for an 8 mm shaft: 55 mm long, 13 mm thick foot, 15 mm to shaft centre, 22 mm bearing housing, two 5 mm slots 42 mm apart, insert bearing with set screw collar
let shaft_d = 8.0; // [5.0, 12.0] Shaft diameter (mm)
let length = 55.0; // [45.0, 80.0] Overall length (mm)
let centre_h = 15.0; // [11.0, 25.0] Shaft centre height (mm)
let hole_spacing = 42.0; // [35.0, 65.0] Mounting hole spacing (mm)
const thick = 13.0;
const rb = 14.0;
let hs = min(hole_spacing, length - 10.0);
let foot = box_centered(length, thick, 5.0).translate([0, 0, 2.5]).fillet(4.0, "|Z");
let housing = cylinder([0, -thick / 2.0, centre_h], "Y", rb, thick) + box_from_corners([-rb, -thick / 2.0, 0], [rb, thick / 2.0, centre_h]);
let blend = polygon("XZ", [[-rb - 10.0, 4.99], [rb + 10.0, 4.99], [rb, centre_h], [-rb, centre_h]]).to_face().extrude([0, thick, 0]).translate([0, -thick / 2.0, 0]);
let b = fuse_all([foot, housing, blend]);
b -= cylinder([0, -thick, centre_h], "Y", 11.0, 2.0 * thick);
for s in [-1.0, 1.0] {
    let x = s * hs / 2.0;
    b -= box_centered(3.0, 5.0, 12.0).translate([x, 0, 0]) + cylinder([x - 1.5, 0, -1], "Z", 2.5, 12.0) + cylinder([x + 1.5, 0, -1], "Z", 2.5, 12.0);
}
let insert = cylinder([0, -thick / 2.0 + 1.0, centre_h], "Y", 10.95, thick - 2.0) + cylinder([0, thick / 2.0 - 1.01, centre_h], "Y", 7.5, 5.0);
insert -= cylinder([0, -thick, centre_h], "Y", shaft_d / 2.0, 3.0 * thick);
insert -= cylinder([0, thick / 2.0 + 1.5, centre_h], "Z", 1.5, 10.0);
compound([b, insert])
