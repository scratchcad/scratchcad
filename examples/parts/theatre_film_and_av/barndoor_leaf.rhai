// Fresnel barn door leaf: 150 x 100 mm trapezoid leaf 1.5 mm thick tapering to 70 mm, with a rolled 6 mm hinge tube along the long edge and 4 mm return flanges along the sides
let length = 150.0; // [100.0, 250.0] Hinge edge length (mm)
let depth = 100.0; // [60.0, 150.0] Leaf depth (mm)
let tip = 70.0; // [40.0, 150.0] Tip edge length (mm)
let thickness = 1.5; // [1.0, 2.5] Sheet thickness (mm)
let tube = 6.0; // [4.0, 10.0] Hinge tube diameter (mm)
let pts = [[-length / 2.0, 0], [length / 2.0, 0], [tip / 2.0, depth], [-tip / 2.0, depth]];
let leaf = polygon("XY", pts).to_face().extrude([0, 0, thickness]);
let hinge = cylinder([-length / 2.0, 0, tube / 2.0], "X", tube / 2.0, length) - cylinder([-length / 2.0 - 1.0, 0, tube / 2.0], "X", tube / 2.0 - thickness, length + 2.0);
// side flanges: thin walls along the slanted edges
let flanges = [];
for s in [-1.0, 1.0] {
    flanges.push(polygon("XY", [[s * length / 2.0, tube / 2.0], [s * tip / 2.0, depth], [s * (tip / 2.0 - thickness * 1.5), depth], [s * (length / 2.0 - thickness * 1.5), tube / 2.0]]).to_face().extrude([0, 0, 4.0 + thickness]));
}
leaf + hinge + fuse_all(flanges)
