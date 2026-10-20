// Mug tea infuser basket: 60 mm basket 65 mm deep, 1.2 mm wall with 24 vertical slots 1 mm wide, perforated base, 90 mm resting flange 1.5 mm thick with two lift tabs
let basket_diameter = 60.0; // [40.0, 80.0] Basket diameter (mm)
let depth = 65.0; // [30.0, 100.0] Basket depth (mm)
let flange_diameter = 90.0; // [70.0, 120.0] Flange diameter (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let slot_count = 24; // [8, 48] Number of side slots
let slot_width = 1.0; // [0.6, 2.0] Slot width (mm)
let r = basket_diameter / 2.0;
let rf = max(flange_diameter / 2.0, r + 5.0);
let basket = cylinder([0, 0, -depth], "Z", r, depth + 0.1).fillet(6.0, "%CIRCLE and <Z");
basket = basket + cylinder(rf, 1.5);
for s in [-1.0, 1.0] {
    basket += box_centered(14.0, 24.0, 1.5).translate([s * (rf + 4.0), 0, 0.75]).fillet(5.0, "|Z and " + if s > 0.0 { ">X" } else { "<X" });
}
basket = basket - (cylinder([0, 0, -depth + wall], "Z", r - wall, depth) .fillet(6.0 - wall, "%CIRCLE and <Z"));
// slots in the side wall, from 10 mm below the flange to the start of the base curve
let cuts = [];
for i in 0..slot_count {
    cuts.push(box_centered(3.0 * wall + 2.0, slot_width, depth - 20.0).translate([r, 0, -depth / 2.0 - 3.0]).rotate_z(i.to_float() * 360.0 / slot_count.to_float()));
}
// base perforation: two rings of 1.5 mm holes and one at the centre
cuts.push(cylinder([0, 0, -depth - 1.0], "Z", 0.75, 3.0));
for ring in [[8.0, 8], [16.0, 16]] {
    for j in 0..ring[1] {
        cuts.push(cylinder([ring[0], 0, -depth - 1.0], "Z", 0.75, 3.0).rotate_z(j.to_float() * 360.0 / ring[1].to_float()));
    }
}
basket - compound(cuts)
