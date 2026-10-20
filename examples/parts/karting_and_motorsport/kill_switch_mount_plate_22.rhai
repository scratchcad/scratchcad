// Motorsport kill switch mounting plate: 70 x 50 x 3 mm plate with 4 mm rounded corners, a 22.5 mm hole with a 3.2 x 1.5 mm anti-rotation notch for a 22 mm switch, four M4 holes (4.3 mm) 8 mm in from the corners and a 1 mm raised border 3 mm wide on the face
let length = 70.0; // [50.0, 100.0] Plate length (mm)
let width = 50.0; // [40.0, 80.0] Plate width (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
const switch_d = 22.5;
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let border = box_centered(length, width, 1.0).translate([0, 0, thickness + 0.5]);
let border = border.fillet(4.0, border.edges("|Z")) - box_centered(length - 6.0, width - 6.0, 3.0).translate([0, 0, thickness + 0.5]);
let body = plate + border;
let cuts = [
    cylinder([0, 0, -1.0], "Z", switch_d / 2.0, thickness + 3.0),
    box_centered(3.2, 3.0, thickness + 3.0).translate([0, switch_d / 2.0, thickness / 2.0])
];
for s in [-1.0, 1.0] {
    for t in [-1.0, 1.0] {
        cuts.push(cylinder([s * (length / 2.0 - 8.0), t * (width / 2.0 - 8.0), -1.0], "Z", 2.15, thickness + 3.0));
    }
}
body - fuse_all(cuts)
