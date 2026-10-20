// Trailer coupling handle grip: 110 mm sleeve for a 25 x 10 mm flat lever, 32 x 20 mm oval-ish octagonal grip with 4 finger scallops and a 10 mm closed end
let length = 110.0; // [80.0, 140.0] Grip length (mm)
let lever_w = 25.0; // [18.0, 28.0] Lever width (mm)
const lever_t = 10.0;
let pts = [];
for i in 0..8 { let a = (22.5 + 45.0 * i.to_float()) * PI() / 180.0; pts.push([0, 17.0 * cos(a) / cos(PI() / 8.0), 11.0 * sin(a) / cos(PI() / 8.0)]); }
let g = face(polygon(pts)).extrude([length, 0, 0]);
let scallops = [];
for i in 0..4 { scallops.push(cylinder([20.0 + i.to_float() * (length - 35.0) / 3.0, -20.0, -16.0], "Y", 6.0, 40.0)); }
g - fuse_all(scallops) - box_from_corners([-1.0, -lever_w / 2.0 - 0.3, -lever_t / 2.0 - 0.3], [length - 10.0, lever_w / 2.0 + 0.3, lever_t / 2.0 + 0.3])
