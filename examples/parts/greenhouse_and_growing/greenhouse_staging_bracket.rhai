// Greenhouse staging bracket: shelf bracket that bolts into the T-slot of an aluminium greenhouse upright, 150 x 150 mm triangular gusset bracket 4 mm thick with 20 mm flanges, two 8 mm slots for M6 slot bolts and two 5 mm shelf-board screw holes
// # Bracket
let arm = 150.0; // [80.0, 250.0] Arm length (mm)
let flange = 20.0; // [15.0, 30.0] Flange width (mm)
let thickness = 4.0; // [3.0, 6.0] Material thickness (mm)
// # Holes
let bolt_slot = 8.0; // [6.0, 10.0] Bolt slot width (mm)
let screw = 5.0; // [4.0, 6.0] Shelf screw hole diameter (mm)
let upright = box_from_corners([0, -flange / 2.0, 0], [thickness, flange / 2.0, arm]);
let shelf = box_from_corners([0, -flange / 2.0, arm - thickness], [arm, flange / 2.0, arm]);
let web = polygon("XZ", [[thickness - 0.5, arm * 0.25], [thickness - 0.5, arm - thickness + 0.5], [arm * 0.75, arm - thickness + 0.5]]).to_face().extrude([0, thickness, 0]).translate([0, -thickness / 2.0, 0]);
let lightening = polygon("XZ", [[thickness + 12.0, arm * 0.25 + 30.0], [thickness + 12.0, arm - thickness - 10.0], [arm * 0.75 - 30.0, arm - thickness - 10.0]]).to_face().extrude([0, thickness * 3.0, 0]).translate([0, -thickness * 1.5, 0]);
let body = upright + shelf + (web - lightening);
let slots = [];
for z in [arm * 0.2, arm * 0.6] {
    slots.push(fuse_all([cylinder([-1.0, 0, z], "X", bolt_slot / 2.0, thickness + 2.0), cylinder([-1.0, 0, z + 12.0], "X", bolt_slot / 2.0, thickness + 2.0), box_from_corners([-1.0, -bolt_slot / 2.0, z], [thickness + 1.0, bolt_slot / 2.0, z + 12.0])]));
}
let screws = [cylinder([arm * 0.5, 0, arm - thickness - 1.0], "Z", screw / 2.0, thickness + 2.0), cylinder([arm - 12.0, 0, arm - thickness - 1.0], "Z", screw / 2.0, thickness + 2.0)];
body - compound(slots) - compound(screws)
