// Trophy base: 80 x 80 mm stepped plinth 30 mm tall (60 mm upper step 10 mm), 2 mm chamfers, a 60 x 15 mm plaque recess 1 mm deep on the front and an M5 rod hole 5.5 mm through
let size = 80.0; // [60.0, 120.0] Base size (mm)
let height = 30.0; // [20.0, 45.0] Base height (mm)
let lower = box_centered(size, size, height - 10.0).translate([0, 0, (height - 10.0) / 2.0]);
let lower = lower.chamfer(2.0, lower.edges(">Z"));
let upper = box_centered(size - 20.0, size - 20.0, 10.01).translate([0, 0, height - 5.0]);
let upper = upper.chamfer(1.5, upper.edges(">Z"));
let plaque = box_centered(size * 0.75, 2.0, (height - 10.0) * 0.6).translate([0, -size / 2.0, (height - 10.0) / 2.0]);
lower + upper - plaque - cylinder([0, 0, -1.0], "Z", 2.75, height + 2.0)
