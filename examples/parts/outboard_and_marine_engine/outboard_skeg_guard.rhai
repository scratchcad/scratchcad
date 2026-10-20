// Outboard skeg guard: 4 mm stainless-style U shoe 180 mm long slipping over a 10 mm thick skeg, 30 mm deep sides with the bottom 8 mm thick, tail end raked at 30 degrees, and three M6 bolt holes (6.4 mm) through both sides 45 mm apart
let length = 180.0; // [100.0, 250.0] Guard length (mm)
let skeg_t = 10.0; // [6.0, 16.0] Skeg thickness (mm)
let side_h = 30.0; // [20.0, 45.0] Side depth (mm)
const wall = 4.0;
const bottom = 8.0;
let w = skeg_t + 2.0 * wall;
let shoe = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, bottom + side_h]);
let slot = box_from_corners([-1.0, -skeg_t / 2.0, bottom], [length + 1.0, skeg_t / 2.0, bottom + side_h + 1.0]);
let rake = face(polygon([[length, -w, bottom + side_h + 1.0], [length - (bottom + side_h) * tan(30.0 * PI() / 180.0), -w, bottom + side_h + 1.0], [length + 1.0, -w, -1.0], [length + 1.0, -w, bottom + side_h + 1.0]])).extrude([0, 2.0 * w, 0]);
let cuts = [slot, rake];
for i in 0..3 {
    cuts.push(cylinder([20.0 + i.to_float() * 45.0, -w, bottom + side_h * 0.55], "Y", 3.2, 2.0 * w));
}
shoe - fuse_all(cuts)
