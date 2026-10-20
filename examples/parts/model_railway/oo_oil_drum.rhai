// 1:76 scale 45 gallon oil drum: 7.5 mm diameter, 11.5 mm tall, two rolling hoops, filler bung
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
const d = 7.5;
const h = 11.5;
let drum = cylinder(d / 2.0, h);
let hoops = [];
for z in [h / 3.0, 2.0 * h / 3.0] { hoops.push(cylinder([0, 0, z - 0.2], "Z", d / 2.0 + 0.2, 0.4)); }
let rim = cylinder([0, 0, h - 0.5], "Z", d / 2.0, 0.6) - cylinder([0, 0, h - 0.4], "Z", d / 2.0 - 0.3, 1.0);
let bung = cylinder([1.8, 0, h - 0.41], "Z", 0.5, 0.3);
let top = drum - cylinder([0, 0, h - 0.4], "Z", d / 2.0 - 0.3, 1.0) + rim;
(top + fuse_all(hoops) + bung).scale(s)
