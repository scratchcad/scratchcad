// Greenhouse vent opener bracket: frame bracket for a wax-cylinder automatic roof vent opener, 80 x 40 mm base plate 5 mm thick with four 5.5 mm slots for 20 mm aluminium glazing bar bolts, two 30 mm tall clevis ears 6 mm apart with an 8 mm pivot pin hole
// # Plate
let plate_l = 80.0; // [60.0, 120.0] Plate length (mm)
let plate_w = 40.0; // [30.0, 60.0] Plate width (mm)
let thickness = 5.0; // [3.0, 8.0] Plate thickness (mm)
// # Clevis
let ear_height = 30.0; // [20.0, 45.0] Ear height (mm)
let ear_gap = 6.5; // [4.0, 12.0] Gap between ears (mm)
let pin = 8.0; // [5.0, 10.0] Pivot pin diameter (mm)
const ear_t = 5.0;
let plate = box_from_corners([-plate_l / 2.0, -plate_w / 2.0, 0], [plate_l / 2.0, plate_w / 2.0, thickness]).fillet(5.0, "|Z");
let ears = [];
for s in [-1.0, 1.0] {
    let y0 = if s > 0.0 { ear_gap / 2.0 } else { -ear_gap / 2.0 - ear_t };
    let e = box_from_corners([-10.0, y0, thickness - 0.01], [10.0, y0 + ear_t, thickness + ear_height]).fillet(9.5, "|Y and >Z");
    ears.push(e);
}
let body = plate + fuse_all(ears);
let pin_hole = cylinder([0, -plate_w, thickness + ear_height - 10.0], "Y", pin / 2.0 + 0.1, plate_w * 2.0);
let slots = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let x = sx * (plate_l / 2.0 - 10.0);
        let y = sy * (plate_w / 2.0 - 8.0);
        slots.push(fuse_all([cylinder([x - 4.0, y, -1.0], "Z", 2.75, thickness + 2.0), cylinder([x + 4.0, y, -1.0], "Z", 2.75, thickness + 2.0), box_from_corners([x - 4.0, y - 2.75, -1.0], [x + 4.0, y + 2.75, thickness + 1.0])]));
    }
}
body - pin_hole - compound(slots)
