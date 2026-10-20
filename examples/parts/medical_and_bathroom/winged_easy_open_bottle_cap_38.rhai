// Easy-open winged pill bottle cap: 38 mm cap 16 mm tall with internal thread ridge, two 22 mm wings for arthritic hands, ribbed rim
let cap_diameter = 38.0; // [28.0, 55.0] Cap diameter (mm)
let cap_height = 16.0; // [10.0, 24.0] Cap height (mm)
let wing_reach = 22.0; // [10.0, 35.0] Wing reach beyond the cap (mm)
let wing_thickness = 4.0; // [2.5, 6.0] Wing thickness (mm)
let wall = 1.8; // [1.2, 3.0] Wall thickness (mm)
let R = cap_diameter / 2.0;
let cap = cylinder(R, cap_height).fillet(1.5, ">Z");
let wings = box_centered(cap_diameter + 2.0 * wing_reach, wing_thickness, cap_height - 2.0).translate([0, 0, cap_height / 2.0 + 1.0]).fillet(wing_thickness * 0.45, "|Z");
let body = fuse_all([cap, wings]);
body -= cylinder([0, 0, -1.0], "Z", R - wall, cap_height - wall + 1.0);
let ridges = [];
for i in 0..3 {
    ridges.push(polygon([[R - wall + 0.05, 0, -0.6], [R - wall - 0.9, 0, -0.2], [R - wall - 0.9, 0, 0.2], [R - wall + 0.05, 0, 0.6]]).to_face()
        .revolve([0, 0, 0], "Z", 100.0).translate([0, 0, 4.0 + i.to_float() * 1.2]).rotate_z(i.to_float() * 120.0));
}
fuse_all([body] + ridges)
