// Hoof pick: 140 mm, 20 mm wide handle 8 mm thick, 35 mm hooked pick 5 mm, hanging hole
let length = 140.0; // [100.0, 180.0] Handle length (mm)
let width = 20.0; // [15.0, 30.0] Handle width (mm)
let t = 8.0; // [5.0, 12.0] Handle thickness (mm)
let handle = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let h1 = handle.fillet(5.0, handle.edges("|Z"));
let h = h1.fillet(2.0, h1.edges("not |Z"));
let pick = polygon([[length - 2.0, -3.0], [length + 16.0, -3.0], [length + 25.0, -8.0], [length + 31.0, -32.0], [length + 35.0, -32.0], [length + 30.0, -5.0], [length + 18.0, 3.0], [length - 2.0, 3.0]]).to_face().extrude([0, 0, 5.0]).translate([0, 0, 1.5]);
h + pick - cylinder([10.0, 0, -1], "Z", 3.5, t + 2.0)
