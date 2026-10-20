// Figure-eight descender: 10 mm plate, 72 mm big ring for the rope bight and 28 mm small ring for the carabiner, 150 mm overall with eased edges
let big = 72.0; // [60.0, 85.0] Large ring hole diameter (mm)
let small = 28.0; // [22.0, 35.0] Small ring hole diameter (mm)
const t = 10.0;
const rim = 12.0;
let cb = big / 2.0 + rim;
let cs = small / 2.0 + rim;
let x2 = cb + cs - 6.0;
let outer = cylinder([0, 0, 0], "Z", cb, t) + cylinder([x2, 0, 0], "Z", cs, t) + box_from_corners([0, -cs + 4.0, 0], [x2, cs - 4.0, t]);
let f = outer - cylinder([0, 0, -1.0], "Z", big / 2.0, t + 2.0) - cylinder([x2, 0, -1.0], "Z", small / 2.0, t + 2.0);
f.fillet(2.0, f.edges("%CIRCLE"))
