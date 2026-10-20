// Positive top-post battery terminal: SAE taper bore 19.5 to 17.5 mm over 16 mm, slotted ears with M8 bolt, 25 mm2 crimp barrel
let h = 16.0; // [12.0, 20.0] Clamp height (mm)
let body = cylinder(14.0, h) + box_from_corners([8.0, -7.0, 0], [26.0, 7.0, h]) + cylinder([-30.0, 0, h / 2.0], "X", 7.0, 20.0);
body -= cone(9.8125, 8.6875, 18.0).translate([0, 0, -1.0]);
body -= box_from_corners([8.0, -1.0, -1.0], [27.0, 1.0, h + 1.0]);
body -= cylinder([20.0, -8.0, h / 2.0], "Y", 4.2, 16.0);
body - cylinder([-31.0, 0, h / 2.0], "X", 4.5, 18.0)
