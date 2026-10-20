// Caravan levelling ramp: 3-step chock 450 mm long, 170 mm wide, steps of 30, 60 and 90 mm, with a 20 mm stop lip and three lightening pockets under the flats, 10 mm below the treads
let length = 450.0; // [300.0, 600.0] Ramp length (mm)
let width = 170.0; // [140.0, 230.0] Ramp width (mm)
let step = 30.0; // [20.0, 40.0] Step rise (mm)
let run = length / 4.0;
let prof = polygon([[0, 0, 0], [length, 0, 0], [length, 0, 3.0 * step + 20.0], [length - 20.0, 0, 3.0 * step + 20.0], [length - 20.0, 0, 3.0 * step], [3.0 * run, 0, 3.0 * step], [2.5 * run, 0, 2.0 * step], [2.0 * run, 0, 2.0 * step], [1.5 * run, 0, step], [run, 0, step], [0, 0, 0]]);
let r = face(prof).extrude([0, width, 0]);
let pockets = [];
for k in 1..4 { pockets.push(box_from_corners([run * k.to_float() + 5.0, 15.0, -1.0], [run * (k.to_float() + 0.5) - 5.0, width - 15.0, k.to_float() * step - 10.0])); }
r - fuse_all(pockets)
