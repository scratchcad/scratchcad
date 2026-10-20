// Eurorack 3U 8HP blank panel (Doepfer A-100 spec): 128.5 x 40.3 x 2 mm, 3.2 mm mounting slots 5.5 mm long at 7.5 mm from the left edge and 5 HP further, 3 mm from top and bottom, rear stiffening rib
let hp = 8; // [2, 20] Width in HP units
let height = 128.5; // [128.0, 128.5] Panel height (mm)
let thick = 2.0; // [1.6, 3.0] Panel thickness (mm)
let rib = 6.0; // [0.0, 10.0] Rear rib depth (mm)
const unit = 5.08;
let width = hp.to_float() * unit - 0.3;
let panel = box_from_corners([0, 0, 0], [width, height, thick]);
let shapes = [panel];
if rib > 0.5 && width > 6.0 {
    shapes.push(box_from_corners([width / 2.0 - 0.8, 12.0, thick - 0.5], [width / 2.0 + 0.8, height - 12.0, thick + rib]));
}
let body = fuse_all(shapes);
let xs = [7.5];
if hp >= 6 {
    xs.push(7.5 + (hp - 3).to_float() * unit);
}
let slots = [];
for x in xs {
    for y in [3.0, height - 3.0] {
        let x0 = min(x, width - 4.0);
        slots.push(box_centered(2.3, 3.2, thick + 2.0).translate([x0, y, thick / 2.0]) + cylinder([x0 - 1.15, y, -1], "Z", 1.6, thick + 2.0) + cylinder([x0 + 1.15, y, -1], "Z", 1.6, thick + 2.0));
    }
}
body - compound(slots)
