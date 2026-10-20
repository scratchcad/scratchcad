// Three-pole busbar support base for 10 x 5 mm copper bars on edge: 60 mm pole pitch, 150 x 20 x 18 mm insulating block with 5.4 mm wide 10.4 mm deep slots, M5 clearance holes (5.5 mm) for the clamp screws between the poles and two 6.5 mm fixing holes at the ends
let pitch = 60.0; // [40.0, 100.0] Pole pitch (mm)
let bar_t = 5.0; // [4.0, 10.0] Bar thickness (mm)
let bar_h = 10.0; // [10.0, 20.0] Bar height (mm)
const width = 20.0;
let height = bar_h + 8.0;
let length = 2.0 * pitch + 30.0;
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(1.0, block.edges("|Y and >Z"));
let cuts = [];
for i in [-1.0, 0.0, 1.0] {
    cuts.push(box_centered(bar_t + 0.4, width + 2.0, bar_h + 0.4).translate([i * pitch, 0, height - (bar_h + 0.4) / 2.0 + 0.5]));
}
for i in [-0.5, 0.5] {
    cuts.push(cylinder([i * pitch, 0, -1.0], "Z", 2.75, height + 2.0));
}
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * (pitch + 9.0), 0, -1.0], "Z", 3.25, height + 2.0));
}
block - fuse_all(cuts)
