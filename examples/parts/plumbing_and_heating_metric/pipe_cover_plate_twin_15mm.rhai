// Radiator twin pipe cover plate for two 15 mm pipes at 50 mm centres: 74 x 30 x 4 mm plate, 15.5 mm holes, push-on slits to the lower edge, 1 mm top chamfer
let centres = 50.0; // [35.0, 80.0] Pipe centres (mm)
let pipe = 15.0; // [10.0, 22.0] Pipe size (mm)
let height = 30.0; // [24.0, 45.0] Plate height (mm)
let thick = 4.0; // [2.5, 6.0] Plate thickness (mm)
let slit = 1.2; // [0.6, 3.0] Push-on slit width (mm)
let length = centres + pipe + 9.0;
let plate = box_centered(length, height, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(min(height * 0.3, 8.0), plate.edges("|Z"));
let plate = plate.chamfer(1.0, plate.edges(">Z"));
let cuts = [];
for x in [-centres / 2.0, centres / 2.0] {
    cuts.push(cylinder([x, 0, -1], "Z", pipe / 2.0 + 0.25, thick + 2.0));
    cuts.push(box_from_corners([x - slit / 2.0, -height, -1], [x + slit / 2.0, 0, thick + 1.0]));
}
plate - fuse_all(cuts)
