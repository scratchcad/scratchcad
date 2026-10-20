// Greenhouse glazing W-clip: spring clip holding 3 mm horticultural glass against an aluminium glazing bar, 12 mm wide, 1.2 mm thick wire-style strip folded into a W 20 mm across with 10 mm hooks, 3.2 mm glass gap each side
// # Clip
let width = 12.0; // [8.0, 18.0] Clip width (mm)
let strip = 1.2; // [0.8, 2.0] Strip thickness (mm)
let span = 20.0; // [14.0, 30.0] Clip span across the bar (mm)
// # Glass
let glass = 3.2; // [2.5, 5.0] Glass gap (mm)
let hook = 10.0; // [6.0, 15.0] Hook length (mm)
let h = span / 2.0;
let pts = [[-h, 0.0], [-h / 2.0, -6.0], [0.0, 0.0], [h / 2.0, -6.0], [h, 0.0]];
let segs = [];
for i in 0..4 {
    let a = pts[i];
    let b = pts[i + 1];
    let dx = b[0] - a[0];
    let dy = b[1] - a[1];
    let len = (dx * dx + dy * dy).sqrt();
    let ang = dy.atan(dx) * 180.0 / PI();
    segs.push(box_from_corners([0, -strip / 2.0, 0], [len, strip / 2.0, width]).rotate_z(ang).translate([a[0], a[1], 0]));
    segs.push(cylinder([b[0], b[1], 0], "Z", strip * 0.75, width));
}
segs.push(cylinder([pts[0][0], pts[0][1], 0], "Z", strip * 0.75, width));
for s in [-1.0, 1.0] {
    segs.push(box_from_corners([s * h - strip / 2.0, -0.01, 0], [s * h + strip / 2.0, glass + strip, width]));
    let lip = box_from_corners([0, glass + strip / 2.0, 0], [hook, glass + strip * 1.5, width]);
    segs.push(if s < 0.0 { lip.translate([-h - hook + strip / 2.0, 0, 0]) } else { lip.translate([h - strip / 2.0, 0, 0]) });
}
fuse_all(segs)
