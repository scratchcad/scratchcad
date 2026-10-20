// 20 mm shaft with two DIN 471 retaining ring grooves: 19.0 mm groove diameter, 1.3 mm wide, 60 mm long, grooves 8 mm in from each end, 0.5 mm end chamfers
let shaft_diameter = 20.0; // [8.0, 60.0] Shaft diameter (mm)
let length = 60.0; // [25.0, 200.0] Shaft length (mm)
let groove_diameter = 19.0; // [7.0, 58.0] Groove diameter (mm)
let groove_width = 1.3; // [0.8, 3.0] Groove width (mm)
let groove_inset = 8.0; // [3.0, 30.0] Groove distance from each end (mm)
let r = shaft_diameter / 2.0;
let rg = min(groove_diameter / 2.0, r - 0.3);
let gi = min(groove_inset, length / 2.0 - groove_width);
let shaft = cylinder(r, length).chamfer(0.5, "%CIRCLE");
let rings = [];
for z in [gi, length - gi - groove_width] {
    rings.push(cylinder([0, 0, z], "Z", r + 1.0, groove_width) - cylinder([0, 0, z - 1.0], "Z", rg, groove_width + 2.0));
}
shaft - compound(rings)
