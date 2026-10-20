// Car seat gap filler: 240 mm long wedge between seat and centre console, 32 mm top tapering to 12 mm at 60 mm deep, 2.5 mm hollow shell open underneath, 26 x 45 mm slot for the seat belt buckle stalk
let length = 240.0; // [180.0, 320.0] Length (mm)
let depth = 60.0; // [40.0, 90.0] Depth into the gap (mm)
let top = 32.0; // [24.0, 45.0] Top width (mm)
let bottom = 12.0; // [8.0, 20.0] Bottom width (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let slot_pos = 170.0; // [100.0, 220.0] Buckle slot position from the front (mm)

const slot_w = 26.0;
const slot_l = 45.0;
let section = |t, b, h, z0| {
    polygon([[0, -b / 2.0, z0], [0, b / 2.0, z0], [0, t / 2.0, h], [0, -t / 2.0, h]]).to_face()
};
let outer = section.call(top, bottom, depth, 0.0).extrude([length, 0, 0]);
outer = outer.fillet(5.0, outer.edges("|X and >Z"));
let nose = box_from_corners([0, -top / 2.0, -1.0], [length + 1.0, top / 2.0, depth + 1.0]);
nose = nose.fillet(top / 2.0 - 1.0, nose.edges("|Z and <X"));
outer = outer & nose;
let slope = (top - bottom) / 2.0 / depth;
let inner = section.call(top - 2.0 * wall, bottom - 2.0 * wall + 2.0 * slope * wall, depth - wall, -1.0).extrude([length - 2.0 * wall, 0, 0]).translate([wall, 0, 0]);
inner = inner.fillet(2.5, inner.edges("|X and >Z"));
let inner_nose = box_from_corners([wall, -top / 2.0 + wall, -2.0], [length, top / 2.0 - wall, depth]);
inner = inner & inner_nose.fillet(top / 2.0 - wall - 1.0, inner_nose.edges("|Z and <X"));
let filler = outer - inner;
let sx = min(slot_pos, length - slot_l / 2.0 - 15.0);
let sw = min(slot_w, top - 2.0 * wall - 6.0);
filler - box_from_corners([sx - slot_l / 2.0, -sw / 2.0, -1.0], [sx + slot_l / 2.0, sw / 2.0, depth + 1.0])
