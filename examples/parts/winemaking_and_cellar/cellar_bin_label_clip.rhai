// Cellar bin label clip: clips over a 20 mm rack slat, 45 x 30 mm slate panel 2 mm thick angled 15 degrees, with a 1.5 mm spring jaw
let slat = 20.0; // [12.0, 30.0] Rack slat thickness (mm)
let panel_w = 45.0; // [30.0, 70.0] Label width (mm)
const t = 2.0;
let jaw = box_from_corners([0, 0, 0], [panel_w, slat + 2.0 * t, t]) + box_from_corners([0, 0, -12.0], [panel_w, t, 0.01]) + box_from_corners([0, slat + t, -12.0], [panel_w, slat + 2.0 * t, 0.01]);
let barb = box_from_corners([0, slat + t - 0.8, -12.0], [panel_w, slat + t + 0.01, -10.0]);
let panel = box_from_corners([0, 0, 0], [panel_w, t, 30.0]).rotate_x(-15.0).translate([0, -0.5, t - 0.5]);
jaw + barb + panel
