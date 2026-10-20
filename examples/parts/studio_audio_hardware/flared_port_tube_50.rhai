// Bass reflex port tube: 50 mm ID, 3 mm wall, 120 mm long, a 10 mm conical flare at the mouth inside a 4 mm mounting flange 12 mm wide and a 4 mm flare at the inner end
let id = 50.0; // [30.0, 100.0] Port inside diameter (mm)
let length = 120.0; // [50.0, 250.0] Port length (mm)
const wall = 3.0;
const flare = 10.0;
let r = id / 2.0;
let prof = polygon([[r + flare, 0, 0], [r + flare + 12.0, 0, 0], [r + flare + 12.0, 0, 4.0], [r + flare + wall, 0, 4.0], [r + wall, 0, flare + wall], [r + wall, 0, length - 6.0], [r + wall + 4.0, 0, length], [r + 4.0, 0, length], [r, 0, length - 6.0], [r, 0, flare]]);
let tube = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let holes = [];
for i in 0..4 { let a = (45.0 + 90.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([(r + flare + 6.0) * cos(a), (r + flare + 6.0) * sin(a), -1.0], "Z", 1.75, 6.0)); }
tube - fuse_all(holes)
