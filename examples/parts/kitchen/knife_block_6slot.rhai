// Six-slot knife block: 120 x 100 mm footprint, body leaning back 20 deg, 230 mm long, slots 2.5 to 4 mm wide and 20 to 50 mm long, 200 mm deep, 10 mm corner radii
let width = 120.0; // [80.0, 200.0] Block width (mm)
let body_depth = 100.0; // [70.0, 150.0] Block depth front to back (mm)
let body_length = 230.0; // [150.0, 320.0] Block length along the slots (mm)
let lean = 20.0; // [0.0, 35.0] Lean back from vertical (deg)
let slot_depth = 200.0; // [100.0, 280.0] Slot depth (mm)
// the block is modelled upright (slots along Z), then leaned back and cut flat at the floor
let block = box_centered(width, body_depth, body_length).translate([0, 0, body_length / 2.0]).fillet(10.0, "|Z").fillet(4.0, ">Z");
let slots = [[-36.0, -18.0, 50.0, 4.0], [0.0, -18.0, 50.0, 4.0], [36.0, -18.0, 45.0, 3.5],
             [-36.0, 22.0, 32.0, 3.0], [0.0, 22.0, 26.0, 2.5], [36.0, 22.0, 20.0, 2.5]];
let cuts = [];
let depth_clamped = min(slot_depth, body_length - 15.0);
for s in slots {
    cuts.push(box_centered(s[3], s[2], depth_clamped + 1.0).translate([s[0], s[1], body_length - depth_clamped / 2.0 + 0.5]).rotate_z(90.0).rotate_z(-90.0).translate([0, 0, 0]));
}
block = block - compound(cuts);
let leaned = block.rotate([0, body_depth / 2.0, 0], "X", -lean);
leaned & box_centered(3.0 * width, 4.0 * body_depth, 3.0 * body_length).translate([0, 0, 1.5 * body_length])
