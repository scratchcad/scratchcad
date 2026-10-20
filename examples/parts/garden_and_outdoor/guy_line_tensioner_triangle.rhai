// Aluminium triangle guy-line tensioner: 38 mm sides, 3 mm thick, two 5 mm cord holes and a 2.5 mm locking slot, rounded corners
let side = 38.0; // [25.0, 60.0] Side length (mm)
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let hole_diameter = 5.0; // [3.0, 7.0] Cord hole diameter (mm)
let slot_width = 2.5; // [1.5, 4.0] Locking slot width (mm)
let h = side * sqrt(3.0) / 2.0;
let tri = polygon([[-side / 2.0, 0], [side / 2.0, 0], [0, h]]).to_face().extrude(thickness).fillet(side * 0.15, "|Z").chamfer(0.4, ">Z or <Z");
let rh = hole_diameter / 2.0;
let holes = [cylinder([-side * 0.22, h * 0.24, -1.0], "Z", rh, thickness + 2.0),
             cylinder([side * 0.22, h * 0.24, -1.0], "Z", rh, thickness + 2.0)];
// locking slot: a hole near the apex with a narrow cut that opens to the edge
let slot_y = h * 0.58;
holes.push(cylinder([0, slot_y, -1.0], "Z", rh * 0.8, thickness + 2.0));
holes.push(box_from_corners([0, slot_y - slot_width / 2.0, -1.0], [side, slot_y + slot_width / 2.0, thickness + 1.0]).rotate([0, slot_y, 0], "Z", 25.0));
tri - fuse_all(holes)
