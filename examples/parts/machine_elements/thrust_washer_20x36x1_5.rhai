// Bronze thrust washer DIN 1834 style, 20 x 36 x 1.5 mm: two radial lube grooves 0.4 mm deep, 3 mm anti-rotation hole on a 28 mm circle
let inner_diameter = 20.0; // [6.0, 60.0] Inner diameter (mm)
let outer_diameter = 36.0; // [12.0, 100.0] Outer diameter (mm)
let thickness = 1.5; // [0.8, 4.0] Thickness (mm)
let groove_width = 2.0; // [0.5, 4.0] Lube groove width (mm)
let ri = inner_diameter / 2.0;
let ro = max(outer_diameter / 2.0, ri + 4.0);
let washer = cylinder(ro, thickness) - cylinder([0, 0, -1], "Z", ri, thickness + 2.0);
let gd = min(0.4, thickness * 0.3);
let grooves = [];
for a in [0.0, 180.0] {
    grooves.push(box_from_corners([ri - 1.0, -groove_width / 2.0, thickness - gd], [ro + 1.0, groove_width / 2.0, thickness + 1.0]).rotate("Z", a));
}
washer = washer - compound(grooves);
washer - cylinder([0, (ri + ro) / 2.0, -1], "Z", 1.5, thickness + 2.0)
