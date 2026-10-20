// Front-loader door handle: 120 mm curved pull, 25 mm wide, 18 mm tall grip, 2 M5 bosses 90 mm apart
let length = 120.0; // [80.0, 160.0] Handle length (mm)
let width = 25.0; // [18.0, 35.0] Width (mm)
let height = 18.0; // [12.0, 25.0] Grip height (mm)
let pitch = 90.0; // [60.0, 130.0] Boss spacing (mm)
let arc = cylinder([0, -width / 2.0, -150.0 + height], "Y", 150.0, width) - cylinder([0, -width, -150.0 + height], "Y", 150.0 - 6.0, width * 2.0);
let a = arc & box_from_corners([-length / 2.0, -width, 0], [length / 2.0, width, height + 1.0]);
let bosses = [];
for s in [-1.0, 1.0] { bosses.push(cylinder([s * pitch / 2.0, 0, 0], "Z", 5.0, height - 4.0) - cylinder([s * pitch / 2.0, 0, -1], "Z", 2.1, height - 6.0)); }
a + fuse_all(bosses)
