// Lid for a 100 x 60 mm project box: 100 x 60 x 2.5 mm plate with 4 mm corner radius, 1.5 mm locating lip 4 mm tall inset 2.2 mm, 4 countersunk M3 holes 5 mm from the corners with lip notches
let length = 100.0; // [50.0, 200.0] Lid length (mm)
let width = 60.0; // [40.0, 150.0] Lid width (mm)
let thick = 2.5; // [1.5, 4.0] Lid thickness (mm)
let lip_h = 4.0; // [0.0, 8.0] Locating lip height (mm)
let inset = 2.2; // [1.2, 4.0] Lip inset from the edge (mm)
let corner = 4.0; // [1.0, 8.0] Corner radius (mm)
let hole_in = 5.0; // [4.0, 10.0] Hole distance from the edges (mm)
let plate = box_centered(length, width, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(corner, plate.edges("|Z"));
let parts = [plate];
if lip_h > 0.3 {
    let lo = box_centered(length - 2.0 * inset, width - 2.0 * inset, lip_h + 0.5).translate([0, 0, thick + (lip_h - 0.5) / 2.0]);
    let li = box_centered(length - 2.0 * inset - 3.0, width - 2.0 * inset - 3.0, lip_h + 2.0).translate([0, 0, thick + lip_h / 2.0]);
    let ro = max(corner - inset, 0.5);
    parts.push(lo.fillet(ro, lo.edges("|Z")) - li.fillet(max(ro - 1.5, 0.3), li.edges("|Z")));
}
let holes = [];
let notches = [];
for x in [-1.0, 1.0] {
    for y in [-1.0, 1.0] {
        let cx = x * (length / 2.0 - hole_in);
        let cy = y * (width / 2.0 - hole_in);
        holes.push(cylinder([cx, cy, -1], "Z", 1.7, thick + lip_h + 2.0) + cone(3.5, 1.7, 1.8).translate([cx, cy, -0.3]));
        notches.push(cylinder([cx, cy, thick], "Z", 4.0, lip_h + 1.0));
    }
}
fuse_all(parts) - compound(notches) - compound(holes)
