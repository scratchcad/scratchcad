// GT2 belt crimp clip for 6 mm belt: 22 x 22.5 x 8 mm block, 6.5 mm belt channel 2.5 mm deep along the length with GT2 tooth ridges (1 mm wide, 0.75 mm high, 2 mm pitch) in the floor, 2 x M3 clamp holes beside the channel
let length = 22.0; // [14.0, 40.0] Clip length (mm)
let belt_w = 6.5; // [6.2, 10.5] Belt channel width (mm)
let height = 8.0; // [6.0, 12.0] Block height (mm)
let channel = 2.5; // [1.5, 3.5] Channel depth (mm)
const pitch = 2.0;
let width = belt_w + 16.0;
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
block = block.fillet(1.5, "|Z");
block = block - box_centered(length + 2.0, belt_w, channel + 1.0).translate([0, 0, height - channel + (channel + 1.0) / 2.0]);
let n = ((length - 2.0) / pitch).floor().to_int();
let ridges = [];
for i in 0..n {
    let x = (i.to_float() - (n.to_float() - 1.0) / 2.0) * pitch;
    ridges.push(box_centered(1.0, belt_w + 0.5, 1.25).translate([x, 0, height - channel + 0.125]));
}
block = block + fuse_all(ridges);
let holes = [];
for sy in [-1.0, 1.0] {
    holes.push(cylinder([0, sy * (belt_w / 2.0 + 4.0), -1], "Z", 1.6, height + 2.0));
    holes.push(cylinder([0, sy * (belt_w / 2.0 + 4.0), -0.01], "Z", 3.0, 3.0));
}
block - fuse_all(holes)
