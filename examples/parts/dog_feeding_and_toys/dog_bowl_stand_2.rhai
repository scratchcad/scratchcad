// Raised dog bowl stand: 420 x 220 mm top 8 mm thick with two 180 mm bowl holes on 210 mm centres and four 15 mm-thick legs 150 mm tall at the corners
let hole = 180.0; // [120.0, 200.0] Bowl hole diameter (mm)
let height = 150.0; // [80.0, 300.0] Stand height (mm)
const t = 8.0;
let pitch = hole + 30.0;
let length = 2.0 * pitch;
let width = hole + 40.0;
let top = box_centered(length, width, t).translate([0, 0, height - t / 2.0]);
let top = top.fillet(10.0, top.edges("|Z"));
let legs = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { legs.push(box_centered(15.0, 40.0, height - t + 0.02).translate([sx * (length / 2.0 - 15.0), sy * (width / 2.0 - 30.0), (height - t) / 2.0])); } }
top + fuse_all(legs) - cylinder([-pitch / 2.0, 0, height - t - 1.0], "Z", hole / 2.0, t + 2.0) - cylinder([pitch / 2.0, 0, height - t - 1.0], "Z", hole / 2.0, t + 2.0)
