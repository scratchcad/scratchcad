// BLTouch mount bracket: 26 x 12 mm probe plate with 18 mm hole spacing (M3) and a 40 x 20 mm carriage flange with two M3 holes
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let drop = 20.0; // [8.0, 40.0] Vertical drop (mm)
let probe_spacing = 18.0; // [18.0, 18.0] Probe hole spacing (mm)
let flange = box(40.0, thickness, 20.0);
let web = box(26.0, thickness, drop).translate([7.0, 0, -drop + 0.01]);
let plate = box(26.0, 18.0, thickness).translate([7.0, -18.0 + thickness, -drop]);
let gusset = polygon("YZ", [[thickness, -drop + thickness], [-15.0 + thickness, -drop + thickness], [thickness, -2.0]]).to_face().extrude([thickness, 0, 0]).translate([18.5, -thickness + 3.0, 0]);
let part = fuse_all([flange, web, plate]);
for x in [8.0, 32.0] { part -= cylinder([x, -1, 12.0], "Y", 1.65, thickness + 2.0); }
for s in [-1, 1] { part -= cylinder([20.0 + s * probe_spacing / 2.0, -9.0 + thickness, -drop - 1], "Z", 1.65, thickness + 2.0); }
part - cylinder([20.0, -9.0 + thickness, -drop - 1], "Z", 4.0, thickness + 2.0)
