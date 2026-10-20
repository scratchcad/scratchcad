// AM4 cooler retention clip: 95 mm strap 1.2 mm steel style, 15 mm wide, hooks 6 mm, center lever hole
let span = 95.0; // [80.0, 110.0] Span between hooks (mm)
let width = 15.0; // [10.0, 20.0] Width (mm)
let t = 1.2; // [1.0, 2.0] Thickness (mm)
let bow = 6.0; // [3.0, 10.0] Center bow height (mm)
let strap = polygon([[-span / 2.0, 0], [-span / 4.0, bow], [span / 4.0, bow], [span / 2.0, 0], [span / 2.0, t], [span / 4.0, bow + t], [-span / 4.0, bow + t], [-span / 2.0, t]]).to_face().extrude([0, 0, width]).rotate_x(90.0);
let hooks = [];
for s in [-1.0, 1.0] { hooks.push(box_from_corners([s * span / 2.0 - t / 2.0, -width, -10.0], [s * span / 2.0 + t / 2.0, 0, t]) - box_from_corners([s * span / 2.0 - 2.0, -width / 2.0 - 3.0, -8.0], [s * span / 2.0 + 2.0, -width / 2.0 + 3.0, -4.0])); }
strap + fuse_all(hooks) - cylinder([0, -width / 2.0, -1], "Z", 2.5, bow + t + 2.0)
