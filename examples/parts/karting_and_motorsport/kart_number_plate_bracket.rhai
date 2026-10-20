// Kart rear number plate bracket: 40 x 45 x 16.5 mm saddle block with a 25 mm half-round groove underneath and two M5 holes (5.3 mm) for a U-bolt, carrying a 4 mm upright plate 80 mm wide and 60 mm tall with two M5 holes (5.3 mm) 60 mm apart for the number panel and 3 mm rounded top corners
let tube_d = 25.0; // [16.0, 32.0] Bumper tube diameter (mm)
let plate_w = 80.0; // [50.0, 120.0] Plate width (mm)
let plate_h = 60.0; // [40.0, 90.0] Plate height (mm)
let hole_spacing = 60.0; // [30.0, 100.0] Panel hole spacing (mm)
let block_h = tube_d / 2.0 + 4.0;
let bw = tube_d + 20.0;
let block = box_centered(40.0, bw, block_h).translate([0, 0, block_h / 2.0]);
let plate = box_from_corners([-plate_w / 2.0, -2.0, block_h - 1.0], [plate_w / 2.0, 2.0, block_h + plate_h]);
let plate = plate.fillet(3.0, plate.edges("|Y and >Z"));
let body = block + plate;
let sp = min(hole_spacing, plate_w - 14.0);
let cuts = [cylinder([-30.0, 0, 0], "X", tube_d / 2.0 + 0.2, 60.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([0, s * (tube_d / 2.0 + 5.0), -1.0], "Z", 2.65, block_h + 2.0));
    cuts.push(cylinder([s * sp / 2.0, -3.0, block_h + plate_h - 10.0], "Y", 2.65, 6.0));
}
body - fuse_all(cuts)
