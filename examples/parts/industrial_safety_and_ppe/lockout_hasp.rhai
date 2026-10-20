// Lockout hasp jaw plate: 6-hole steel hasp, 38 mm jaw opening, 3 mm plate 120 x 50 mm, six 10 mm padlock holes on a 13 mm pitch
let jaw = 38.0; // [25.0, 50.0] Jaw opening (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
let hole = 10.0; // [8.0, 12.0] Padlock hole diameter (mm)
let holes = 6; // [4, 8] Number of padlock holes
let pitch = hole + 3.5;
let width = 50.0; // [40.0, 70.0] Plate width (mm)
let tail = holes.to_float() * pitch + 8.0;
let length = jaw + 12.0 + tail;
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let p = plate.fillet(6.0, plate.edges("|Z"));
// semicircular jaw at the head end with a straight tongue
let jaw_cut = cylinder([6.0 + jaw / 2.0, 0, -1], "Z", jaw / 2.0, thickness + 2.0) + box_from_corners([6.0 + jaw / 2.0, -jaw / 2.0, -1], [6.0 + jaw, width, thickness + 1.0]);
let lock_holes = [];
for i in 0..holes {
    lock_holes.push(cylinder([jaw + 18.0 + i.to_float() * pitch, 0, -1], "Z", hole / 2.0, thickness + 2.0));
}
// pivot hole for the matching jaw
let pivot = cylinder([length - 6.0, width / 2.0 - 8.0, -1], "Z", 3.0, thickness + 2.0);
p - jaw_cut - compound(lock_holes) - pivot
