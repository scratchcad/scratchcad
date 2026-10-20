// Mounting plate for a wireless video receiver on a cage: 90 x 60 x 4 mm plate with 3 mm corner radii, four 2.7 mm holes on a 76 x 46 mm pattern for the receiver's M2.5 screws, two 3 mm wide hook-and-loop strap slots 25 mm long near the ends, and a 1/4-20 clearance hole (6.5 mm) plus a 3/8-16 clearance hole (9.8 mm) in the middle
let length = 90.0; // [70.0, 140.0] Plate length (mm)
let width = 60.0; // [45.0, 90.0] Plate width (mm)
let thickness = 4.0; // [3.0, 8.0] Plate thickness (mm)
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let cuts = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        cuts.push(cylinder([sx * (length / 2.0 - 7.0), sy * (width / 2.0 - 7.0), -1.0], "Z", 1.35, thickness + 2.0));
    }
    cuts.push(box_centered(3.0, 25.0, thickness + 2.0).translate([sx * (length / 2.0 - 14.0), 0, thickness / 2.0]));
}
cuts.push(cylinder([-8.0, 0, -1.0], "Z", 3.25, thickness + 2.0));
cuts.push(cylinder([8.0, 0, -1.0], "Z", 4.9, thickness + 2.0));
plate - fuse_all(cuts)
