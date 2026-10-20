// 2.8 in SPI TFT (ILI9341, 86 x 50 mm red PCB, M3 holes on 78.6 x 44.2 mm, 69.2 x 50 mm glass, 57.6 x 43.2 mm active area 4 mm left of centre): 96 x 58 x 2.5 mm bezel, 45-degree window bevel, 4 hex-nut standoffs 6 mm
let plate_w = 96.0; // [90.0, 120.0] Bezel width (mm)
let plate_h = 58.0; // [54.0, 80.0] Bezel height (mm)
let thick = 2.5; // [2.0, 4.0] Plate thickness (mm)
let window_w = 58.0; // [50.0, 62.0] Window width (mm)
let window_h = 44.0; // [38.0, 47.0] Window height (mm)
let standoff = 6.0; // [3.0, 12.0] Standoff height (mm)
const hole_x = 78.6;
const hole_y = 44.2;
const offset = -4.0;
let pw = max(plate_w, hole_x + 10.0);
let ph = max(plate_h, max(hole_y, window_h) + 9.0);
let plate = box_centered(pw, ph, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let b = min(1.2, thick * 0.5);
let bevel = loft([rect(plane([offset, 0, -0.5], [0, 0, 1]), window_w + 2.0 * b + 1.0, window_h + 2.0 * b + 1.0), rect(plane([offset, 0, b], [0, 0, 1]), window_w, window_h)], true);
let window = box_centered(window_w, window_h, thick * 4.0).translate([offset, 0, 0]);
let parts = [plate - window - bevel];
let drills = [];
for x in [-hole_x / 2.0, hole_x / 2.0] {
    for y in [-hole_y / 2.0, hole_y / 2.0] {
        parts.push(cylinder([x, y, thick - 0.5], "Z", 3.5, standoff + 0.5));
        drills.push(cylinder([x, y, 1.0], "Z", 1.25, standoff + thick));
    }
}
fuse_all(parts) - compound(drills)
