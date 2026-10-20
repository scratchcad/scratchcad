// 5 mm through-hole LED: 5 mm dome on a 5.8 mm flange with a flat, 8.6 mm tall, leads 2.54 mm apart (anode longer)
let diameter = 5.0; // [3.0, 10.0] Lens diameter (mm)
let height = 8.6; // [5.0, 14.0] Height above the flange (mm)
let flange_d = 5.8; // [3.8, 11.0] Flange diameter (mm)
let r = diameter / 2.0;
let lens = cylinder([0, 0, 1.0], "Z", r, height - r - 1.0) + sphere([0, 0, height - r], r);
let flange = cylinder(flange_d / 2.0, 1.0) - box_from_corners([flange_d / 2.0 - 0.5, -5, -1], [5, 5, 2]);
let leads = box_centered(0.5, 0.5, 25.0).translate([-1.27, 0, -12.5]) + box_centered(0.5, 0.5, 27.0).translate([1.27, 0, -13.5]);
fuse_all([lens, flange, leads])
