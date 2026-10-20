// Garage door bottom seal retainer end cap: closes a 60 x 15 mm aluminium retainer, 3 mm cap with a 50 x 8 mm push-in tongue 20 mm long and twin T-slot keys for the seal bulbs
let width = 60.0; // [40.0, 80.0] Retainer width (mm)
let height = 15.0; // [10.0, 25.0] Retainer height (mm)
const t = 3.0;
let cap = box_centered(width + 4.0, t, height + 4.0).translate([0, -t / 2.0, height / 2.0]);
let tongue = box_centered(width - 10.0, 20.0, 8.0).translate([0, 10.0 - 0.01, height / 2.0]);
let keys = box_centered(6.0, 20.0, 3.0).translate([-width / 2.0 + 8.0, 10.0, 1.5]) + box_centered(6.0, 20.0, 3.0).translate([width / 2.0 - 8.0, 10.0, 1.5]);
cap + tongue + keys
