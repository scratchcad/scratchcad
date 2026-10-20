// Wall-mounted sachet dispenser for 80 x 60 mm medicine sachets: open-top box 86 mm wide, 20 mm deep inside and 120 mm tall with 2 mm walls and floor, a 70 x 12 mm pull-out slot at the bottom of the front with a 40 mm semicircular thumb notch above it, and two 5/9 mm keyhole slots in the back
let sachet_w = 80.0; // [50.0, 120.0] Sachet width (mm)
let stack_depth = 20.0; // [10.0, 40.0] Inside depth (mm)
let height = 120.0; // [70.0, 180.0] Box height (mm)
let slot_h = 12.0; // [6.0, 20.0] Pull-out slot height (mm)
const wall = 2.0;
let iw = sachet_w + 6.0;
let ow = iw + 2.0 * wall;
let od = stack_depth + 2.0 * wall;
let shell = box_from_corners([-ow / 2.0, 0, 0], [ow / 2.0, od, height]) - box_from_corners([-iw / 2.0, wall, wall], [iw / 2.0, od - wall, height + 1.0]);
let sw = sachet_w - 10.0;
let notch_w = min(40.0, sw - 10.0);
let cutters = [
    box_from_corners([-sw / 2.0, -1.0, wall], [sw / 2.0, wall + 1.0, wall + slot_h]),
    (cylinder([0, -1.0, wall + slot_h], "Y", notch_w / 2.0, wall + 2.0) & box_from_corners([-notch_w, -2.0, wall + slot_h - 1.0], [notch_w, wall + 2.0, height])),
];
let kz = height - 20.0;
for x in [-ow / 4.0, ow / 4.0] {
    cutters.push(cylinder([x, od - wall - 1.0, kz], "Y", 4.5, wall + 2.0));
    cutters.push(box_from_corners([x - 2.5, od - wall - 1.0, kz - 10.0], [x + 2.5, od + 1.0, kz]));
    cutters.push(cylinder([x, od - wall - 1.0, kz - 10.0], "Y", 2.5, wall + 2.0));
}
shell - fuse_all(cutters)
