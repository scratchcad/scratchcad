// Playing card holder: 200 x 45 mm curved fan base 25 mm tall that holds a hand of cards, two staggered 2 mm card slots 15 mm deep angled back 10 degrees, non-slip 1 mm feet recesses
// # Base
let length = 200.0; // [140.0, 260.0] Base length (mm)
let depth = 45.0; // [35.0, 60.0] Base depth (mm)
let height = 25.0; // [18.0, 35.0] Base height (mm)
// # Slots
let slot_w = 2.0; // [1.2, 3.5] Card slot width (mm)
let slot_depth = 15.0; // [8.0, 20.0] Slot depth (mm)
let lean = 10.0; // [0.0, 20.0] Slot lean back (degrees)
let profile = polygon("YZ", [[-depth / 2.0, 0.0], [depth / 2.0, 0.0], [depth / 2.0 - 6.0, height], [-depth / 2.0 + 6.0, height]]).to_face();
let base = profile.extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]).fillet(3.0, "|Y");
let slots = [];
for k in [[-depth * 0.15, 0.0], [depth * 0.15, 8.0]] {
    slots.push(box_centered(length - 20.0 - k[1], slot_w, slot_depth * 2.0).rotate_x(-lean).translate([0, k[0], height]));
}
let feet = [];
for x in [-length / 2.0 + 15.0, length / 2.0 - 15.0] {
    feet.push(cylinder([x, 0, -0.01], "Z", 7.5, 1.0));
}
base - fuse_all(slots) - compound(feet)
