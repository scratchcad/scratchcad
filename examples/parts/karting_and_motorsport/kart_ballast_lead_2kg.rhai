// Kart ballast weight, about 2 kg of lead (11.34 g/cc): 150 x 75 x 16 mm plate with 3 mm rounded corners, 1 mm chamfered top edges and two 8.5 x 20 mm M8 slots 100 mm apart, countersunk 16 mm for flat-head bolts
let length = 150.0; // [80.0, 200.0] Weight length (mm)
let width = 75.0; // [50.0, 100.0] Weight width (mm)
let thickness = 16.0; // [8.0, 25.0] Weight thickness (mm)
let slot_spacing = 100.0; // [50.0, 150.0] Slot spacing (mm)
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let plate = plate.chamfer(1.0, plate.edges(">Z"));
let sp = min(slot_spacing, length - 30.0);
let cuts = [];
for s in [-1.0, 1.0] {
    for t in [-1.0, 1.0] {
        let x = s * sp / 2.0;
        let y = t * 5.75;
        cuts.push(cylinder([x, y, -1.0], "Z", 4.25, thickness + 2.0));
        cuts.push(cone(4.25, 8.25, 4.0).translate([x, y, thickness - 3.99]));
    }
    cuts.push(box_centered(8.5, 11.5, thickness + 2.0).translate([s * sp / 2.0, 0, thickness / 2.0]));
    cuts.push(face(polygon([[s * sp / 2.0 - 4.25, -5.75, 0], [s * sp / 2.0 + 4.25, -5.75, 0], [s * sp / 2.0 + 8.25, -5.75, 4.0], [s * sp / 2.0 - 8.25, -5.75, 4.0]])).extrude([0, 11.5, 0]).translate([0, 0, thickness - 3.99]));
}
let w = plate - fuse_all(cuts);
print(`mass ${w.volume() * 0.01134} g`);
w
