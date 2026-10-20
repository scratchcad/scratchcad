// Tennis net centre strap ground anchor: 100 x 40 x 6 mm plate with two countersunk 8 mm bolt holes and a 12 mm loop bar 30 mm wide standing 20 mm for the strap hook
let length = 100.0; // [80.0, 150.0] Plate length (mm)
let bar = 12.0; // [8.0, 16.0] Loop bar diameter (mm)
const t = 6.0;
let plate = box_centered(length, 40.0, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(6.0, plate.edges("|Z"));
let loop_ = box_from_corners([-15.0 - bar, -bar / 2.0, t - 0.01], [15.0 + bar, bar / 2.0, t + 20.0]) - box_from_corners([-15.0, -bar, t - 1.0], [15.0, bar, t + 20.0 - bar]);
let holes = [];
for x in [-length / 2.0 + 12.0, length / 2.0 - 12.0] {
    holes.push(cylinder([x, 0, -1.0], "Z", 4.0, t + 2.0));
    holes.push(cone(4.0, 8.0, 4.0).translate([x, 0, t - 3.99]));
}
plate + loop_ - fuse_all(holes)
