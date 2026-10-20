// SMA bulkhead antenna bracket: 2 mm L-bracket 20 mm wide, 24 mm upright with 6.5 mm D-hole (6 mm across the flat) for a 1/4-36 SMA bulkhead jack, 16 mm base leg with 2 x M3 slots 3.2 x 6 mm, side gussets
let width = 20.0; // [14.0, 32.0] Bracket width (mm)
let upright = 24.0; // [16.0, 40.0] Upright height (mm)
let leg = 16.0; // [10.0, 30.0] Base leg depth (mm)
let thick = 2.0; // [1.5, 3.5] Plate thickness (mm)
let hole = 6.5; // [6.4, 8.5] Bulkhead hole diameter (mm)
let flat = 6.0; // [5.5, 8.0] Across the flat (mm)
let up = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thick, upright]);
let up = up.fillet(min(width * 0.3, 5.0), up.edges("|Y and >Z"));
let base = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, leg, thick]);
let parts = [up, base];
for x in [-width / 2.0, width / 2.0 - thick] {
    parts.push(polygon([[x, thick - 0.5, thick - 0.5], [x, leg * 0.7, thick - 0.5], [x, thick - 0.5, upright * 0.45]]).to_face().extrude([thick, 0, 0]));
}
let zc = max(upright - width * 0.45, thick + hole / 2.0 + 2.0);
let fl = min(flat, hole - 0.2);
let dhole = cylinder([0, -1, zc], "Y", hole / 2.0, thick + 2.0) & box_from_corners([-hole, -2, zc - hole / 2.0 - 1.0], [hole, thick + 2.0, zc - hole / 2.0 + fl]);
let slots = [];
for x in [-width / 4.0, width / 4.0] {
    let y = (thick + leg) / 2.0 + 0.5;
    slots.push(box_centered(3.2, 2.8, thick + 2.0).translate([x, y, thick / 2.0]) + cylinder([x, y - 1.4, -1], "Z", 1.6, thick + 2.0) + cylinder([x, y + 1.4, -1], "Z", 1.6, thick + 2.0));
}
fuse_all(parts) - dhole - compound(slots)
