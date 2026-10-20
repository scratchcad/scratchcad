// Motorcycle front brake master cylinder reservoir cap: 58 x 40 mm, 3.5 mm thick, 6 mm corner radius, four M4 countersunk screw holes on 48 x 30 mm, 0.6 mm recessed label panel, 1.5 mm locating lip underneath
let length = 58.0; // [40.0, 80.0] Length (mm)
let width = 40.0; // [28.0, 60.0] Width (mm)
let thickness = 3.5; // [2.5, 6.0] Thickness (mm)
let corner_r = 6.0; // [2.0, 9.0] Corner radius (mm)
let hole_x = 48.0; // [30.0, 70.0] Hole spacing along the length (mm)
let hole_y = 30.0; // [18.0, 50.0] Hole spacing across (mm)
const screw = 4.3;
let hx = min(hole_x, length - 8.0) / 2.0;
let hy = min(hole_y, width - 8.0) / 2.0;
let cr = min(corner_r, width / 2.0 - 1.0);
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]).fillet(cr, "|Z");
let lip = box_centered(length - 14.0, width - 14.0, 1.5).translate([0, 0, -0.75]).fillet(2.0, "|Z");
let cap = plate + lip;
cap = cap - box_centered(2.0 * hx - 12.0, 2.0 * hy - 6.0, 2.0).translate([0, 0, thickness]).fillet(1.5, "|Z");
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        cap = cap - cylinder([sx * hx, sy * hy, -1.0], "Z", screw / 2.0, thickness + 2.0) - cone(screw / 2.0, screw / 2.0 + 2.0, 2.0).translate([sx * hx, sy * hy, thickness - 1.99]);
    }
}
cap
