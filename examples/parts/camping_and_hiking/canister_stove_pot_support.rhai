// Canister stove pot support arm: 55 mm folding arm, 3 mm stainless, serrated top, 4 mm pivot hole
let length = 55.0; // [40.0, 75.0] Arm length (mm)
let height = 14.0; // [10.0, 20.0] Arm height (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
let arm = polygon([[0, 0], [length, height * 0.5], [length, height], [0, height]]).to_face().extrude(thickness);
let teeth = [];
for k in 0..8 { teeth.push(polygon([[12.0 + k.to_float() * 5.0, height - 0.01], [14.5 + k.to_float() * 5.0, height + 2.0], [17.0 + k.to_float() * 5.0, height - 0.01]]).to_face().extrude(thickness)); }
let a = arm + fuse_all(teeth);
let a2 = a.rotate_x(90.0);
a2 - cylinder([5.0, -thickness - 1.0, height / 2.0], "Y", 2.0, thickness + 2.0)
