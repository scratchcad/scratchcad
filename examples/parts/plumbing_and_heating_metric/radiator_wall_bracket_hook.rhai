// Steel panel radiator wall bracket (Type 21/22 hook): 25 mm wide 2 mm strip, 90 mm backplate, 52 mm cantilever arm, 15 mm upturned lip, triangular gusset, two 6 mm screw slots
let width = 25.0; // [20.0, 40.0] Bracket width (mm)
let thick = 2.0; // [1.5, 3.0] Steel thickness (mm)
let back_h = 90.0; // [60.0, 140.0] Backplate height (mm)
let reach = 52.0; // [35.0, 90.0] Arm reach from the wall (mm)
let lip = 15.0; // [8.0, 25.0] Lip height (mm)
let profile = polygon([[0, 0, 0], [0, reach, 0], [0, reach, lip], [0, reach - thick, lip], [0, reach - thick, thick], [0, thick, thick], [0, thick, back_h], [0, 0, back_h]]);
let body = profile.to_face().extrude([width, 0, 0]);
let gusset = polygon([[width / 2.0 - thick / 2.0, thick - 0.5, thick - 0.5], [width / 2.0 - thick / 2.0, reach * 0.65, thick - 0.5], [width / 2.0 - thick / 2.0, thick - 0.5, back_h * 0.45]]).to_face().extrude([thick, 0, 0]);
let slots = [];
for z in [back_h * 0.55, back_h * 0.85] {
    let s = box_centered(6.0, thick + 2.0, 12.0).translate([width / 2.0, thick / 2.0, z]);
    slots.push(s + cylinder([width / 2.0, -1, z - 6.0], "Y", 3.0, thick + 2.0) + cylinder([width / 2.0, -1, z + 6.0], "Y", 3.0, thick + 2.0));
}
body + gusset - compound(slots)
