// Bb clarinet ligature: 28 mm bore ring band 18 mm wide, 1.5 mm thick, two screw lugs with M3 holes
let bore = 28.0; // [24.0, 34.0] Mouthpiece diameter at the reed (mm)
let width = 18.0; // [12.0, 25.0] Band width (mm)
let t = 1.5; // [1.0, 2.5] Band thickness (mm)
let band = cylinder(bore / 2.0 + t, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0);
let lugs = [];
for z in [4.0, width - 4.0] {
    lugs.push(box_from_corners([-6.0, bore / 2.0 - 0.5, z - 2.5], [6.0, bore / 2.0 + 6.0, z + 2.5]) - box_from_corners([-1.0, bore / 2.0 - 1.0, z - 3.0], [1.0, bore / 2.0 + 7.0, z + 3.0]) - cylinder([-7.0, bore / 2.0 + 3.0, z], "X", 1.6, 14.0));
}
band + fuse_all(lugs) - box_from_corners([-1.0, bore / 2.0 - 1.0, -1], [1.0, bore / 2.0 + t + 1.0, width + 1.0])
