// Jaw coupling spider insert, L-075 size: six 13 mm tall legs between 45 deg jaws, 12.7 mm thick, 44 mm across the legs, 22 mm hub ring
let span = 44.0; // [25.0, 80.0] Diameter across the legs (mm)
let thickness = 12.7; // [6.0, 25.0] Spider thickness (mm)
let hub_ring_diameter = 22.0; // [12.0, 40.0] Centre ring diameter (mm)
let leg_width = 5.2; // [2.0, 10.0] Leg width (mm)
const legs = 6;
let ro = span / 2.0;
let rr = min(hub_ring_diameter / 2.0, ro - 4.0);
let pieces = [cylinder(rr, thickness) - cylinder([0, 0, -1], "Z", rr - 2.0, thickness + 2.0)];
for i in 0..legs {
    let leg = box_from_corners([rr - 1.0, -leg_width / 2.0, 0], [ro, leg_width / 2.0, thickness]).fillet(min(leg_width, thickness) * 0.3, "|Z and >X");
    pieces.push(leg.rotate("Z", 30.0 + i.to_float() * 60.0));
}
fuse_all(pieces)
