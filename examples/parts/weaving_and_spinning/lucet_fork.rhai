// Lucet cord-making fork: 110 mm long, 45 mm wide two-prong fork 6 mm thick, 8 mm hole in the handle
let length = 110.0; // [80.0, 150.0] Length (mm)
let width = 45.0; // [35.0, 60.0] Fork width (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let outline = polygon([[0, -10.0], [length * 0.55, -10.0], [length - 5.0, -width / 2.0], [length, -width / 2.0 + 6.0], [length * 0.62, -4.0], [length * 0.62, 4.0], [length, width / 2.0 - 6.0], [length - 5.0, width / 2.0], [length * 0.55, 10.0], [0, 10.0]]).to_face().extrude([0, 0, t]);
let o = outline.fillet(3.0, outline.edges("|Z").filter(|e| e.center().x < length * 0.5));
o - cylinder([length * 0.45, 0, -1], "Z", 4.0, t + 2.0)
