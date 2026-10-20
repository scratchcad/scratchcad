// Snap-in cord strain relief bushing for a 0.5 in (12.7 mm) panel hole, like Heyco SR-5P: 17 mm head, two-part split body with snap shoulders, oval cord grip for 6 x 4 mm SPT-2 cord
let hole_d = 12.7; // [8.0, 22.0] Panel hole diameter (mm)
let panel = 1.6; // [0.8, 3.0] Panel thickness (mm)
let cord_w = 6.0; // [3.0, 9.0] Cord width (mm)
let cord_h = 4.0; // [2.0, 7.0] Cord thickness (mm)
let rh = hole_d / 2.0;
let head = cylinder([0, 0, 0], "Z", rh + 2.5, 3.0).fillet(0.8, ">Z");
let neck = cylinder([0, 0, -panel], "Z", rh - 0.1, panel + 0.1);
let barb = cone(rh + 0.9, rh - 1.0, 4.0).translate([0, 0, -panel - 4.0]);
let tail = cylinder([0, 0, -panel - 12.0], "Z", rh - 1.0, 8.1);
let b = fuse_all([head, neck, barb, tail]);
b -= box_centered(1.4, 2.0 * rh + 6.0, 14.0).translate([0, 0, -panel - 8.0]);
let cw = min(cord_w, hole_d - 4.0);
let ch = min(cord_h, cw);
let cord = box_centered(cw - ch, ch, 40.0) + cylinder([-(cw - ch) / 2.0, 0, -20], "Z", ch / 2.0, 40.0) + cylinder([(cw - ch) / 2.0, 0, -20], "Z", ch / 2.0, 40.0);
b - cord.rotate_z(90.0)
