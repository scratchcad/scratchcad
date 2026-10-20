// Hand dryer wall spacer plate for uneven tiled walls: 220 x 280 mm plate 10 mm thick with 6 mm corner radii, a 60 x 40 mm cable entry window, four 6.5 mm fixing holes on a 180 x 240 mm pattern and four M5 dryer mounting holes (5.5 mm) on a 120 x 180 mm pattern with 9 mm head counterbores 5 mm deep from the wall side
let width = 220.0; // [160.0, 320.0] Plate width (mm)
let height = 280.0; // [200.0, 400.0] Plate height (mm)
let thickness = 10.0; // [6.0, 25.0] Plate thickness (mm)
let dryer_x = 120.0; // [80.0, 140.0] Dryer hole spacing across (mm)
let dryer_y = 180.0; // [120.0, 190.0] Dryer hole spacing down (mm)
let plate = box_centered(width, height, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.fillet(6.0, plate.edges("|Z"));
let cuts = [box_centered(60.0, 40.0, thickness + 2.0).translate([0, -height / 4.0, thickness / 2.0])];
for x in [-1.0, 1.0] {
    for y in [-1.0, 1.0] {
        cuts.push(cylinder([x * (width / 2.0 - 20.0), y * (height / 2.0 - 20.0), -1.0], "Z", 3.25, thickness + 2.0));
        cuts.push(cylinder([x * dryer_x / 2.0, y * dryer_y / 2.0, -1.0], "Z", 2.75, thickness + 2.0));
        cuts.push(cylinder([x * dryer_x / 2.0, y * dryer_y / 2.0, -1.0], "Z", 4.5, min(5.0, thickness - 2.0) + 1.0));
    }
}
plate - fuse_all(cuts)
