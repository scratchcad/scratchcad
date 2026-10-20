// Camping spork: 170 mm long, 40 mm bowl with 4 tines, 2 mm thick, 12 mm handle with a hang hole
let length = 170.0; // [140.0, 200.0] Length (mm)
let bowl_w = 40.0; // [30.0, 50.0] Bowl width (mm)
let thickness = 2.0; // [1.2, 3.0] Thickness (mm)
let cx = length - bowl_w / 2.0;
let shell = (sphere([cx, 0, 30.0], 30.0) - sphere([cx, 0, 30.0], 30.0 - thickness)) & cylinder([cx, 0, -1], "Z", bowl_w / 2.0, 9.0);
let tines = [];
for k in [-1.5, -0.5, 0.5, 1.5] { tines.push(box_centered(12.0, 1.8, 30.0).translate([length - 4.0, k * 7.5, 0])); }
let handle = box_from_corners([0, -6.0, 6.0], [length - bowl_w + 4.0, 6.0, 6.0 + thickness]);
let h = handle.fillet(5.9, handle.edges("|Z and <X")) - cylinder([8.0, 0, 0], "Z", 3.0, 12.0);
shell - compound(tines) + h
