// Ring toss set piece: 150 mm square base 15 mm thick, 25 mm peg 250 mm tall, and a 150 mm rope-style ring 12 mm thick beside it
let peg_h = 250.0; // [150.0, 400.0] Peg height (mm)
let ring_d = 150.0; // [100.0, 250.0] Ring diameter (mm)
let base = box_centered(150.0, 150.0, 15.0).translate([0, 0, 7.5]).fillet(10.0, "|Z").chamfer(2.0, ">Z");
let peg = cylinder([0, 0, 14.0], "Z", 12.5, peg_h).fillet(5.0, ">Z");
let ring = torus(ring_d / 2.0 - 6.0, 6.0).translate([ring_d + 20.0, 0, 6.0]);
compound([base + peg, ring])
