// T-slot nut DIN 508 M10 x 12 for machine-table T-slots: 12 mm tenon, 20 mm head width, 20 mm long, 7 mm head height, 14 mm overall height, 1 mm chamfers
let thread_diameter = 10.0; // [5.0, 24.0] Thread size (mm)
let tenon_width = 12.0; // [6.0, 28.0] Tenon width to fit the slot (mm)
let head_width = 20.0; // [10.0, 48.0] Head width (mm)
let length = 20.0; // [10.0, 50.0] Length (mm)
let head_height = 7.0; // [3.0, 18.0] Head height (mm)
let height = 14.0; // [6.0, 36.0] Overall height (mm)
let tw = min(tenon_width, head_width - 2.0);
let hh = min(head_height, height - 2.0);
let head = box_from_corners([-length / 2.0, -head_width / 2.0, 0], [length / 2.0, head_width / 2.0, hh]);
let tenon = box_from_corners([-length / 2.0, -tw / 2.0, hh - 0.01], [length / 2.0, tw / 2.0, height]);
let nut = (head + tenon).chamfer(min(1.0, hh * 0.15), "|X");
let tap = thread_diameter * 0.85;
nut - cylinder([0, 0, -1], "Z", tap / 2.0, height + 2.0) - cone(tap / 2.0, thread_diameter / 2.0 + 0.5, 1.0).translate([0, 0, height - 0.99])
