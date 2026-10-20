// Repair stand clamp jaw: 70 x 45 mm face, 18 mm thick, 20 mm radius concave cradle 6 mm deep for 27-35 mm seatposts, three 1.5 mm grip grooves round the cradle, M8 tapped centre bore (6.8 mm) and two 4 mm dowel holes in the back, 3 mm rounded corners
let width = 70.0; // [55.0, 90.0] Jaw width (mm)
let height = 45.0; // [35.0, 60.0] Jaw height (mm)
let thickness = 18.0; // [14.0, 25.0] Jaw thickness (mm)
let cradle_r = 20.0; // [14.0, 26.0] Cradle radius (mm)
let cradle_depth = 6.0; // [3.0, 8.0] Cradle depth (mm)
const groove_w = 1.5;
const groove_d = 0.75;
let jaw = box_from_corners([-width / 2.0, 0, -height / 2.0], [width / 2.0, thickness, height / 2.0]);
let jaw = jaw.fillet(3.0, jaw.edges("|Y"));
let cy = -(cradle_r - cradle_depth);
let cutters = [cylinder([0, cy, -height / 2.0 - 1.0], "Z", cradle_r, height + 2.0)];
for k in [-1.0, 0.0, 1.0] {
    cutters.push(cylinder([0, cy, k * height / 4.0 - groove_w / 2.0], "Z", cradle_r + groove_d, groove_w));
}
let bore_depth = min(12.0, thickness - cradle_depth - 3.0);
cutters.push(cylinder([0, thickness + 1.0, 0], "-Y", 3.4, bore_depth + 1.0));
for s in [-1.0, 1.0] {
    cutters.push(cylinder([s * (width / 2.0 - 9.0), thickness + 1.0, 0], "-Y", 2.0, 7.0));
}
jaw - fuse_all(cutters)
