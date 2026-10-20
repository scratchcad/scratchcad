// 20 mm (3/4 in) paracord side-release buckle, assembled: 30 mm wide female sleeve with prong windows, male tongue with two spring prongs
let width = 30.0; // [24.0, 40.0] Buckle width (mm)
let thickness = 9.0; // [7.0, 12.0] Buckle thickness (mm)
let webbing = 20.0; // [15.0, 30.0] Webbing width (mm)
let hw = width / 2.0;
const wall = 2.0;
let cav = hw - wall;
let slot_w = min(webbing + 2.0, width - 4.0) / 2.0;
// female: sleeve open at y = 28, webbing bar at the other end
let female = box_from_corners([-hw, 0, 0], [hw, 28.0, thickness]).fillet(2.0, "|Z and <Y");
female -= box_from_corners([-cav, 8.0, 1.5], [cav, 29.0, thickness - 1.5]);
female -= box_from_corners([-slot_w, 2.0, -1.0], [slot_w, 5.0, thickness + 1.0]);
female -= box_from_corners([-hw - 1.0, 14.0, 1.5], [-cav + 0.01, 22.0, thickness - 1.5]);
female -= box_from_corners([cav - 0.01, 14.0, 1.5], [hw + 1.0, 22.0, thickness - 1.5]);
// male: base with webbing slot, central guide bar and two prongs with catches
const zb = 2.5;
let zt = thickness - 2.5;
let base = box_from_corners([-hw, 30.0, 1.0], [hw, 40.0, thickness - 1.0]).fillet(2.0, "|Z and >Y");
base -= box_from_corners([-slot_w, 34.0, 0], [slot_w, 37.0, thickness]);
let bar = box_from_corners([-4.0, 12.0, zb], [4.0, 30.5, zt]);
let parts = [base, bar];
for s in [-1.0, 1.0] {
    parts.push(box_from_corners([s * (cav - 2.5), 15.0, zb], [s * (cav - 0.5), 30.5, zt]));
    parts.push(box_from_corners([s * (cav - 0.5), 15.5, zb], [s * (hw - 0.3), 21.0, zt]));
}
let male = fuse_all(parts);
compound([female, male])
