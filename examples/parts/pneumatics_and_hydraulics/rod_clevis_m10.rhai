// ISO 8140 rod clevis, M10 x 1.25 for 32 mm cylinders: 20 mm wide, 10 mm slot, 10 mm pin, 40 mm long
let width = 20.0; // [16.0, 32.0] Width (mm)
let slot = 10.0; // [8.0, 16.0] Slot width (mm)
let pin = 10.0; // [8.0, 16.0] Pin diameter (mm)
let length = 40.0; // [32.0, 64.0] Length to pin centre (mm)
let thread_d = 10.0; // [8.0, 16.0] Thread diameter (mm)
let body = box_centered(width, width, length + width / 2.0).translate([0, 0, (length + width / 2.0) / 2.0]);
let round_ = cylinder([-width, 0, length], "X", width / 2.0, width * 2.0) + box_from_corners([-width, -width, 0], [width, width, length]);
let b = body & round_;
b - box_from_corners([-slot / 2.0, -width, length - pin - 6.0], [slot / 2.0, width, length + width]) - cylinder([-width, 0, length], "X", pin / 2.0, width * 2.0) - cylinder([0, 0, -1], "Z", thread_d / 2.0 - 0.7, 16.0)
