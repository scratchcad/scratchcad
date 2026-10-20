// Kart engine mount lower clamp half for two 30 mm chassis rails 90 mm apart: 146 x 40 x 22 mm block with two 30 mm half-round grooves underneath, four M8 clearance holes (8.5 mm) either side of the grooves, two M8 tapped holes (6.8 mm core) on top for the engine plate and 2 mm chamfered top edges
let tube_d = 30.0; // [25.0, 32.0] Chassis tube diameter (mm)
let rail_spacing = 90.0; // [70.0, 120.0] Rail spacing (mm)
let width = 40.0; // [30.0, 60.0] Clamp width (mm)
const height = 22.0;
let length = rail_spacing + tube_d + 26.0;
let block = box_centered(width, length, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(2.0, block.edges(">Z"));
let cuts = [];
for s in [-1.0, 1.0] {
    let y = s * rail_spacing / 2.0;
    cuts.push(cylinder([-width / 2.0 - 1.0, y, 0], "X", tube_d / 2.0 + 0.1, width + 2.0));
    for t in [-1.0, 1.0] {
        cuts.push(cylinder([0, y + t * (tube_d / 2.0 + 7.0), -1.0], "Z", 4.25, height + 2.0));
    }
    cuts.push(cylinder([s * width / 4.0, 0, height - 15.0], "Z", 3.4, 16.0));
}
block - fuse_all(cuts)
