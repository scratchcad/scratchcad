// 4-way 4 mm banana jack / binding post panel: 19.05 mm (0.75 in) spacing, 8.3 mm holes with 7.4 mm anti-rotation flats, 12 mm colour-ring counterbores 0.6 mm, 92 x 30 x 3 mm plate, 2 x 3.2 mm mounting holes, rear stiffening ribs
let posts = 4; // [2, 8] Number of jacks
let spacing = 19.05; // [15.0, 25.4] Jack spacing (mm)
let hole = 8.3; // [6.5, 12.5] Jack hole diameter (mm)
let flats = 7.4; // [5.5, 11.5] Across the flats (mm)
let height = 30.0; // [22.0, 45.0] Panel height (mm)
let thick = 3.0; // [2.0, 5.0] Panel thickness (mm)
let row = (posts - 1).to_float() * spacing;
let length = row + 34.0;
let plate = box_centered(length, height, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let ribs = [];
for y in [-height / 2.0 + 1.0, height / 2.0 - 2.5] {
    ribs.push(box_from_corners([-row / 2.0 - 8.0, y, thick - 0.5], [row / 2.0 + 8.0, y + 1.5, thick + 4.0]));
}
let body = fuse_all([plate] + ribs);
let cuts = [];
for k in 0..posts {
    let x = -row / 2.0 + k.to_float() * spacing;
    let fl = min(flats, hole - 0.4);
    cuts.push(cylinder([x, 0, -1], "Z", hole / 2.0, thick + 2.0) & box_centered(fl, hole + 2.0, thick * 4.0).translate([x, 0, 0]));
    cuts.push(cylinder([x, 0, -1], "Z", min(6.0, spacing / 2.0 - 0.6), 1.6));
}
cuts.push(cylinder([-length / 2.0 + 6.0, 0, -1], "Z", 1.6, thick + 2.0));
cuts.push(cylinder([length / 2.0 - 6.0, 0, -1], "Z", 1.6, thick + 2.0));
body - fuse_all(cuts)
