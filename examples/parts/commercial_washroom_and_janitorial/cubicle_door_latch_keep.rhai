// Toilet cubicle door latch keep for 13 mm panels: 60 x 25 mm wrap-over keep 4 mm thick with a 13.4 mm panel slot 20 mm deep, a 14 mm wing on one side with a 16 mm tall, 10 mm wide bolt pocket 12 mm deep in its front face, and two 4.5 mm countersunk screw holes through the cheek
let panel_t = 13.0; // [10.0, 20.0] Panel thickness (mm)
let height = 60.0; // [45.0, 90.0] Keep height (mm)
let bolt_w = 16.0; // [10.0, 22.0] Bolt pocket height (mm)
let bolt_h = 10.0; // [6.0, 11.0] Bolt pocket width (mm)
const t = 4.0;
const depth = 25.0;
const slot_d = 20.0;
let slot = panel_t + 0.4;
let w = slot + 2.0 * t;
let block = box_from_corners([-w / 2.0, 0, 0], [w / 2.0 + 14.0, depth, height]);
let block = block.fillet(3.0, block.edges("|Z and >X"));
let cuts = [box_from_corners([-slot / 2.0, depth - slot_d, -1.0], [slot / 2.0, depth + 1.0, height + 1.0])];
let bw = min(bolt_w, height - 26.0);
let bh = min(bolt_h, 11.0);
let bx = w / 2.0 + 7.0;
cuts.push(box_from_corners([bx - bh / 2.0, -1.0, height / 2.0 - bw / 2.0], [bx + bh / 2.0, 12.0, height / 2.0 + bw / 2.0]));
for z in [10.0, height - 10.0] {
    cuts.push(cylinder([-w / 2.0 - 1.0, depth - slot_d / 2.0, z], "X", 2.25, w + 2.0));
    cuts.push(cone(2.25, 4.5, 2.25).rotate_y(-90.0).translate([-w / 2.0 + 2.24, depth - slot_d / 2.0, z]));
}
block - fuse_all(cuts)
