// Welding helmet lens holder: frame for a 4.5 x 2 in (114 x 51 mm) filter lens stack 6 mm deep, 2 mm lips leaving a 100 x 40 mm window, 128 x 65 mm outer, two 6 mm snap pins
let lens_width = 114.0; // [105.0, 120.0] Lens width (mm)
let lens_height = 51.0; // [45.0, 60.0] Lens height (mm)
let stack = 6.0; // [3.0, 10.0] Lens stack depth (mm)
let lip = 7.0; // [4.0, 10.0] Retaining lip width (mm)
const border = 7.0;
let ow = lens_width + 2.0 * border;
let oh = lens_height + 2.0 * border;
let depth = stack + 4.0;
let frame = box_centered(ow, oh, depth).translate([0, 0, depth / 2.0]);
let f = frame.fillet(5.0, frame.edges("|Z"));
let pocket = box_centered(lens_width + 0.5, lens_height + 0.5, stack).translate([0, 0, 2.0 + stack / 2.0]);
let slot_in = box_from_corners([-(lens_width + 0.5) / 2.0, -(lens_height + 0.5) / 2.0, 2.0], [ow, (lens_height + 0.5) / 2.0, 2.0 + stack]);
let window = box_centered(lens_width - 2.0 * lip, lens_height - 2.0 * lip, depth + 2.0).translate([0, 0, depth / 2.0]);
let w = window.fillet(3.0, window.edges("|Z"));
f - pocket - slot_in - w + cylinder([-ow / 2.0 + 3.5, oh / 2.0 - 3.5, depth - 0.01], "Z", 3.0, 4.0) + cylinder([-ow / 2.0 + 3.5, -oh / 2.0 + 3.5, depth - 0.01], "Z", 3.0, 4.0)
