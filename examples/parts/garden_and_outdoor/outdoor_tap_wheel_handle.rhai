// Outdoor tap (sillcock) wheel handle: 55 mm four-spoke wheel, 8 mm rim, 18 mm hub 14 mm tall with an 8 mm square socket and M4 screw hole
let wheel_diameter = 55.0; // [40.0, 80.0] Wheel diameter (mm)
let rim = 8.0; // [5.0, 12.0] Rim thickness (mm)
let hub_diameter = 18.0; // [14.0, 26.0] Hub diameter (mm)
let hub_height = 14.0; // [10.0, 20.0] Hub height (mm)
let socket = 8.0; // [6.0, 12.0] Square socket size (mm)
let spokes = 4; // [3, 6] Number of spokes
let R = wheel_diameter / 2.0 - rim / 2.0;
let rh = hub_diameter / 2.0;
let ring = torus(R, rim / 2.0).translate([0, 0, hub_height - rim / 2.0]);
let hub = cylinder(rh, hub_height).fillet(1.5, ">Z");
let parts = [ring, hub];
for i in 0..spokes {
    parts.push(box_from_corners([rh - 1.0, -3.0, hub_height - rim + 1.0], [R, 3.0, hub_height - 1.0]).rotate_z(i.to_float() * 360.0 / spokes.to_float()));
}
let wheel = fuse_all(parts);
let s = min(socket, hub_diameter - 6.0);
wheel -= box_centered(s, s, 2.0 * hub_height - 6.0).translate([0, 0, 0]);
wheel - cylinder([0, 0, hub_height - 5.0], "Z", 2.2, 10.0)
