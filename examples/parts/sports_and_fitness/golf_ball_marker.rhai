// Golf ball marker coin: 24 mm diameter, 1.6 mm thick, 0.4 mm engraved ring and putting-line arrow on the face, 1 mm edge chamfer
let diameter = 24.0; // [18.0, 32.0] Diameter (mm)
let thickness = 1.6; // [1.0, 3.0] Thickness (mm)
let engrave = 0.4; // [0.2, 0.8] Engraving depth (mm)
let r = diameter / 2.0;
let coin = cylinder(r, thickness).chamfer(min(0.4, thickness / 3.0), ">Z");
let ring = cylinder([0, 0, thickness - engrave], "Z", r - 1.5, 1.0) - cylinder([0, 0, thickness - engrave - 0.5], "Z", r - 2.3, 2.0);
let shaft = box_centered(1.2, r * 1.1, 1.0).translate([0, -r * 0.1, thickness - engrave + 0.5]);
let head = polygon([[0, r * 0.65], [-3.0, r * 0.35], [3.0, r * 0.35]]).to_face().extrude([0, 0, 1.0]).translate([0, 0, thickness - engrave]);
coin - ring - (shaft + head)
