// Oral syringe holder for 5 ml oral syringes: 34 mm high block with 6 bores of 14.2 mm for the 13.5 mm barrels, 28 mm deep at 20 mm pitch, a 3 mm drain hole under each, 1 mm entry chamfers and 3 mm rounded vertical corners, 12 mm deeper than the bores
let count = 6; // [2, 10] Number of syringes
let bore = 14.2; // [12.0, 16.0] Bore diameter (mm)
let pitch = 20.0; // [17.0, 26.0] Bore spacing (mm)
let height = 34.0; // [28.0, 45.0] Block height (mm)
let depth = 28.0; // [20.0, 36.0] Bore depth (mm)
const drain_r = 1.5;
let d = min(depth, height - 3.0);
let len = count * pitch;
let wide = bore + 12.0;
let block = box_from_corners([0, -wide / 2.0, 0], [len, wide / 2.0, height]);
let block = block.fillet(3.0, block.edges("|Z"));
let cutters = [];
for i in 0..count {
    let x = pitch / 2.0 + i * pitch;
    cutters.push(cylinder([x, 0, height - d], "Z", bore / 2.0, d + 1.0));
    cutters.push(cylinder([x, 0, -1.0], "Z", drain_r, height));
}
let holder = block - fuse_all(cutters);
holder.chamfer(1.0, holder.edges("%CIRCLE and >Z").filter(|e| e.radius() > 4.0))
