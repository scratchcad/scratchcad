// Fence panel U-clip for 44 mm panel frames: 50 mm tall U-channel 44.5 mm inside, 2 mm steel, 25 mm legs with a 30 mm back flange and two 5 mm screw holes in each part
let frame = 44.5; // [40.0, 55.0] Panel frame thickness (mm)
let height = 50.0; // [35.0, 70.0] Clip height (mm)
const t = 2.0;
let back = box_from_corners([-frame / 2.0 - t - 15.0, 0, 0], [frame / 2.0 + t + 15.0, t, height]);
let legs = box_from_corners([-frame / 2.0 - t, t - 0.01, 0], [-frame / 2.0, 25.0, height]) + box_from_corners([frame / 2.0, t - 0.01, 0], [frame / 2.0 + t, 25.0, height]);
let holes = [];
for z in [height * 0.3, height * 0.7] {
    holes.push(cylinder([-frame / 2.0 - t - 8.0, -1.0, z], "Y", 2.5, t + 2.0));
    holes.push(cylinder([frame / 2.0 + t + 8.0, -1.0, z], "Y", 2.5, t + 2.0));
    holes.push(cylinder([-frame, 15.0, z], "X", 2.5, 2.0 * frame));
}
back + legs - fuse_all(holes)
