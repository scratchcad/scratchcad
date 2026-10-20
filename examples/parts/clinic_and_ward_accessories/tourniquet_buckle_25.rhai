// Phlebotomy tourniquet buckle for 25 mm elastic strap: 36 x 30 mm frame 4 mm thick with 4 mm rounded corners, two 26 x 4 mm strap slots, an 8 mm grip bar between them and 1 mm raised teeth
let strap = 25.0; // [15.0, 40.0] Strap width (mm)
let slot_w = 4.0; // [3.0, 6.0] Slot width (mm)
const t = 4.0;
let w = strap + 11.0;
let f = box_centered(w, 30.0, t);
f = f.fillet(4.0, f.edges("|Z"));
let slots = compound([
    box_centered(strap + 1.0, slot_w, t + 2.0).translate([0, -6.0, 0]),
    box_centered(strap + 1.0, slot_w, t + 2.0).translate([0, 6.0, 0]),
]);
let teeth = [];
for i in 0..5 {
    teeth.push(box_centered(1.0, 2.0, 1.01).translate([(i.to_float() - 2.0) * strap / 5.0, 0, t / 2.0 + 0.5]));
}
f - slots + compound(teeth)
