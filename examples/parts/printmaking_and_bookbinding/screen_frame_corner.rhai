// Screen printing frame corner bracket: 60 x 60 mm L of 25 mm wide, 3 mm steel with a gusset and three 4.5 mm screw holes per leg
let leg = 60.0; // [40.0, 90.0] Leg length (mm)
let w = 25.0; // [18.0, 35.0] Leg width (mm)
const t = 3.0;
let l = box_from_corners([0, 0, 0], [leg, w, t]) + box_from_corners([0, 0, 0], [w, leg, t]);
let gusset = face(polygon([[w - 0.01, w - 0.01, 0], [w + 15.0, w - 0.01, 0], [w - 0.01, w + 15.0, 0]])).extrude([0, 0, t]);
let holes = [];
for d in [w / 2.0, leg / 2.0 + w / 4.0, leg - 8.0] {
    holes.push(cylinder([d, w / 2.0, -1.0], "Z", 2.25, t + 2.0));
    if d > w { holes.push(cylinder([w / 2.0, d, -1.0], "Z", 2.25, t + 2.0)); }
}
l + gusset - fuse_all(holes)
