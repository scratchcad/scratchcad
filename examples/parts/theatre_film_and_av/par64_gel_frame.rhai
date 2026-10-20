// PAR64 gel frame: 254 x 254 mm (10 in) colour frame 1.5 mm thick per leaf, 200 mm aperture, folded as two leaves 0.3 mm apart joined at one edge, 10 mm finger tab
let size = 254.0; // [190.0, 300.0] Frame size (mm)
let aperture = 200.0; // [150.0, 240.0] Aperture diameter (mm)
let leaf = 1.5; // [1.0, 2.5] Leaf thickness (mm)
let gap = 0.3; // [0.2, 1.0] Gel gap (mm)
let plate = box_centered(size, size, leaf);
let p = plate.fillet(4.0, plate.edges("|Z"));
let a = p - cylinder([0, 0, -leaf], "Z", aperture / 2.0, leaf * 2.0);
let lower = a.translate([0, 0, leaf / 2.0]);
let upper = a.translate([0, 0, leaf * 1.5 + gap]);
let spine = box_from_corners([-size / 2.0 + 4.0, size / 2.0 - 3.0, leaf - 0.01], [size / 2.0 - 4.0, size / 2.0, leaf + gap + 0.01]);
let tab = box_from_corners([-12.0, -size / 2.0 - 10.0, 0], [12.0, -size / 2.0 + 1.0, leaf]);
lower + upper + spine + tab.fillet(4.0, tab.edges("|Z and <Y"))
