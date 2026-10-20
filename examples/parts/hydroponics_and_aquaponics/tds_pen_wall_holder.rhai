// TDS / EC meter pen wall holder: open-top pocket 32 x 24 mm inside, 50 mm tall, 2.5 mm walls and floor with a 6 mm drain hole, on a 3 mm back plate 60 mm tall with two 4 mm keyhole slots (8 mm heads) for wall screws
let pen_w = 32.0; // [20.0, 45.0] Pen width (mm)
let pen_d = 24.0; // [14.0, 35.0] Pen depth (mm)
let pocket_h = 50.0; // [30.0, 80.0] Pocket height (mm)
const wall = 2.5;
const plate_t = 3.0;
let plate_h = pocket_h + 10.0;
let ow = pen_w + 2.0 * wall;
let od = pen_d + 2.0 * wall;
let pocket = box_from_corners([-ow / 2.0, 0, 0], [ow / 2.0, od, pocket_h]);
let pocket = pocket.fillet(3.0, pocket.edges("|Z and >Y"));
let cavity = box_from_corners([-pen_w / 2.0, wall, wall], [pen_w / 2.0, wall + pen_d, pocket_h + 1.0]);
let plate = box_from_corners([-ow / 2.0, -plate_t, 0], [ow / 2.0, 0.5, plate_h]);
let plate = plate.fillet(4.0, plate.edges("|Y and >Z"));
let body = (pocket - cavity) + plate;
let kz = plate_h - 8.0;
let cuts = [cylinder([0, wall + pen_d / 2.0, -1.0], "Z", 3.0, wall + 2.0)];
for x in [-ow / 4.0, ow / 4.0] {
    cuts.push(cylinder([x, -plate_t - 1.0, kz], "Y", 4.0, plate_t + 1.6));
    cuts.push(cylinder([x, -plate_t - 1.0, kz + 6.0], "Y", 2.0, plate_t + 1.6));
    cuts.push(box_from_corners([x - 2.0, -plate_t - 1.0, kz], [x + 2.0, 0.6, kz + 6.0]));
}
body - fuse_all(cuts)
