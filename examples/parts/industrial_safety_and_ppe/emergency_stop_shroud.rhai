// Emergency stop guard shroud: yellow 60 mm collar 22 mm tall around a 40 mm mushroom button, 22.5 mm panel hole with a 3.2 mm anti-rotation key, two 25 mm raised side ears
let collar = 60.0; // [50.0, 80.0] Collar diameter (mm)
let button = 40.0; // [30.0, 60.0] Button diameter (mm)
let height = 22.0; // [15.0, 35.0] Collar height (mm)
let panel_hole = 22.5; // [16.2, 30.5] Panel hole (mm)
const base_t = 3.0;
let body = cylinder(collar / 2.0, height) - cylinder([0, 0, base_t], "Z", button / 2.0 + 3.0, height);
let ears = box_centered(collar, 18.0, 25.0).translate([0, 0, height + 12.5 - 0.01]) - cylinder([0, -20, height + 25.0], "Y", button / 2.0 + 3.0, 40.0) - box_centered(button + 6.0, 20.0, 60.0);
let hole = cylinder([0, 0, -1], "Z", panel_hole / 2.0, base_t + 2.0) + box_from_corners([panel_hole / 2.0 - 1.0, -1.6, -1], [panel_hole / 2.0 + 1.6, 1.6, base_t + 1.0]);
let e = ears & cylinder(collar / 2.0, height + 30.0);
(body + e) - hole
