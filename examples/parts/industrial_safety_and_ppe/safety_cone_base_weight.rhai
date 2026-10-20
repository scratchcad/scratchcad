// Traffic cone base weight: 380 mm square recycled-rubber collar 30 mm thick with a 270 mm opening (cone body fit) and 30 mm chamfered corners, four 40 mm hand holes
let size = 380.0; // [300.0, 450.0] Base size (mm)
let thickness = 30.0; // [20.0, 50.0] Thickness (mm)
let opening = 270.0; // [200.0, 330.0] Center opening (mm)
let base = box_centered(size, size, thickness).translate([0, 0, thickness / 2.0]);
let b = base.chamfer(30.0, base.edges("|Z")).chamfer(3.0, ">Z");
// the opening tapers to follow the cone flare
let hole = cone(opening / 2.0, opening / 2.0 - 8.0, thickness + 2.0).translate([0, 0, -1.0]);
let hand = [];
for k in 0..4 {
    hand.push(cylinder([size / 2.0 - 40.0, size / 2.0 - 40.0, -1.0], "Z", 20.0, thickness + 2.0).rotate_z(k.to_float() * 90.0));
}
b - hole - compound(hand)
