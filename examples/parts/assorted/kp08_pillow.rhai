// KP08 pillow block bearing housing
let length = 55.0; // [45, 70] Length (mm)
let width = 13.0; // [10, 20] Width (mm)
let height = 29.0; // [24, 36] Height (mm)
let shaft_height = 15.0; // [12, 20] Shaft center height (mm)
let hole_spacing = 42.0; // [34, 56] Mounting hole spacing (mm)
let bore = 8.0; // [6, 12] Bore (mm)
let top_r = height - shaft_height;
const foot_h = 5.0;
let foot = box_centered(length, width, foot_h).translate([0, 0, foot_h / 2.0]).fillet(3.0, "|Z");
let pedestal = box_from_corners([-top_r * 0.8, -width / 2.0, 0], [top_r * 0.8, width / 2.0, shaft_height]);
let dome = cylinder([0, -width / 2.0, shaft_height], "Y", top_r, width);
let body = fuse_all([foot, pedestal, dome]).clean();
for s in [-1, 1] {
    body -= cylinder([s * hole_spacing / 2.0, 0, -1], "Z", 2.5, foot_h + 2);
}
// bearing insert: 22 mm seat with an 8 mm bore ring
body -= cylinder([0, -width / 2.0 - 1, shaft_height], "Y", bore / 2.0, width + 2);
body
