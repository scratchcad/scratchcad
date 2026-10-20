// Blister push-through press frame: 60 x 40 x 10 mm base with a 14 mm drop hole, two 8 mm side pillars carrying a 10 mm bridge 15 mm above the base for the blister card to slide under, with an 8.2 mm plunger guide bore over the drop hole and a 1 mm chamfer on the bore entry
let base_w = 60.0; // [45.0, 80.0] Base width (mm)
let base_d = 40.0; // [30.0, 55.0] Base depth (mm)
let card_gap = 15.0; // [8.0, 25.0] Card gap (mm)
let drop_d = 14.0; // [10.0, 20.0] Drop hole diameter (mm)
let plunger_d = 8.2; // [6.0, 10.0] Plunger bore (mm)
const base_t = 10.0;
const pillar = 8.0;
const bridge_t = 10.0;
let x0 = -base_w / 2.0;
let x1 = base_w / 2.0;
let zb = base_t + card_gap;
let frame = fuse_all([
    box_from_corners([x0, -base_d / 2.0, 0], [x1, base_d / 2.0, base_t]),
    box_from_corners([x0, -10.0, base_t - 0.5], [x0 + pillar, 10.0, zb + 0.5]),
    box_from_corners([x1 - pillar, -10.0, base_t - 0.5], [x1, 10.0, zb + 0.5]),
    box_from_corners([x0, -10.0, zb], [x1, 10.0, zb + bridge_t]),
]);
let frame = frame - fuse_all([
    cylinder([0, 0, -1.0], "Z", drop_d / 2.0, base_t + 2.0),
    cylinder([0, 0, zb - 1.0], "Z", plunger_d / 2.0, bridge_t + 2.0),
]);
frame.chamfer(1.0, frame.edges("%CIRCLE and >Z"))
