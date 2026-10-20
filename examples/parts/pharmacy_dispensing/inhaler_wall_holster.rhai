// Wall holster for a metered-dose inhaler: open-top pocket 47 x 29 mm inside and 60 mm deep with 2 mm walls and 4 mm inside corner radius, a 30 mm slot down the front stopping 15 mm above the 3 mm floor for the mouthpiece and dose counter, on a 4 mm back plate 90 mm tall with two 4.5 mm screw holes countersunk to 9 mm
let inner_w = 47.0; // [35.0, 60.0] Inside width (mm)
let inner_d = 29.0; // [20.0, 40.0] Inside depth (mm)
let pocket_h = 60.0; // [40.0, 80.0] Pocket height (mm)
let slot_w = 30.0; // [15.0, 40.0] Front slot width (mm)
const wall = 2.0;
const floor_t = 3.0;
const back_t = 4.0;
const back_h = 90.0;
let ow = inner_w + 2.0 * wall;
let od = inner_d + 2.0 * wall;
let outer = box_from_corners([-ow / 2.0, -od, 0], [ow / 2.0, 0.5, pocket_h]);
let outer = outer.fillet(4.0 + wall, outer.edges("|Z and <Y"));
let inner = box_from_corners([-inner_w / 2.0, -od + wall, floor_t], [inner_w / 2.0, 1.0, pocket_h + 1.0]);
let inner = inner.fillet(4.0, inner.edges("|Z and <Y"));
let bh = max(back_h, pocket_h + 25.0);
let back = box_from_corners([-ow / 2.0, 0, 0], [ow / 2.0, back_t, bh]);
let sw = min(slot_w, inner_w - 8.0);
let holster = (outer - inner) + back;
let cutters = [box_from_corners([-sw / 2.0, -od - 1.0, floor_t + 15.0], [sw / 2.0, -od + wall + 1.0, pocket_h + 1.0])];
for z in [bh - 10.0, pocket_h / 2.0] {
    cutters.push(cylinder([0, -1.0, z], "Y", 2.25, back_t + 2.0));
    cutters.push(cone(5.0, 2.25, 2.75).rotate_x(-90.0).translate([0, -0.5, z]));
}
holster - fuse_all(cutters)
