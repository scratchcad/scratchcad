// Vixen-style dovetail bar: 44 mm base, 15 mm tall with 60 degree flanks, 200 mm long, slot 6.5 mm for 1/4-20 bolts and a safety stop hole
let length = 200.0; // [120.0, 300.0] Bar length (mm)
let base_w = 44.0; // [42.0, 45.0] Base width (mm)
const height = 15.0;
const flank = 6.0;
let top_w = base_w - 2.0 * flank * 0.5774;
let profile = polygon([[-base_w / 2.0, 0, 0], [base_w / 2.0, 0, 0], [top_w / 2.0, 0, flank], [top_w / 2.0, 0, height], [-top_w / 2.0, 0, height], [-top_w / 2.0, 0, flank]]);
let bar = face(profile).extrude([0, length, 0]);
let slot = box_from_corners([-3.25, 30.0, -1.0], [3.25, length - 30.0, height + 1.0]);
let cbore = box_from_corners([-6.0, 30.0 - 2.75, height - 6.0], [6.0, length - 30.0 + 2.75, height + 1.0]);
let stop = cylinder([0, 12.0, -1.0], "Z", 2.5, height + 2.0);
bar - slot - cbore - stop
