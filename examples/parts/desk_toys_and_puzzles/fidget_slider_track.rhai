// Fidget slider: 60 x 20 x 8 mm body with a 40 mm T-slot track and a separate 10 x 14 mm captive slider block (2 bodies)
let length = 60.0; // [40.0, 90.0] Body length (mm)
let travel = 40.0; // [20.0, 70.0] Slot length (mm)
const w = 20.0;
const h = 8.0;
let body = box_centered(length, w, h).translate([0, 0, h / 2.0]);
let body = body.fillet(4.0, body.edges("|Z"));
let tr = min(travel, length - 12.0);
let slot = box_centered(tr, 6.0, h).translate([0, 0, h / 2.0 + 3.0]) + box_centered(tr, 12.0, 3.0).translate([0, 0, 3.5]);
let slider = box_centered(10.0, 11.4, 2.6).translate([0, 0, 3.5]) + box_centered(6.0, 5.4, 5.0).translate([0, 0, 6.5]) + box_centered(10.0, 14.0, 2.0).translate([0, 0, h + 1.5 + 0.5]);
compound([body - slot, slider])
