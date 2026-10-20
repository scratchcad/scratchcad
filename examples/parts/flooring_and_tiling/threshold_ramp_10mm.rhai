// Door threshold ramp: 10 mm rise over 60 mm run, 300 mm long, with a 2 mm lip, hollowed under the high side by four pockets and four 4 mm countersunk screw holes
let length = 300.0; // [150.0, 900.0] Ramp length (mm)
let rise = 10.0; // [5.0, 20.0] Ramp height (mm)
let run = 60.0; // [40.0, 100.0] Ramp depth (mm)
const wall = 3.0;
let r = face(polygon([[0, 0, 0], [0, run, 0], [0, run, rise], [0, run - 8.0, rise], [0, 0, 2.0]])).extrude([length, 0, 0]);
const n = 4;
let p = (length - wall) / n.to_float();
let pockets = [];
for i in 0..n { pockets.push(box_from_corners([wall + p * i.to_float(), run * 0.6, -1.0], [p * (i.to_float() + 1.0), run - 10.0, rise * 0.4])); }
let holes = [];
for i in 0..4 {
    let x = length * (i.to_float() + 0.5) / 4.0;
    holes.push(cylinder([x, run - 5.0, -1.0], "Z", 2.0, rise + 2.0));
    holes.push(cone(2.0, 4.0, 2.0).translate([x, run - 5.0, rise - 1.99]));
}
r - fuse_all(pockets) - fuse_all(holes)
