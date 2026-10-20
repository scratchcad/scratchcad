// Four-bolt square flange bearing UCF205 for a 25 mm shaft: 95 mm square flange 14 mm thick, 70 mm bolt square with 12 mm holes, 27 mm deep housing, UC205 insert 52 mm OD 34.1 mm wide
let shaft = 25.0; // [12.0, 50.0] Shaft diameter (mm)
let flange_size = 95.0; // [60.0, 160.0] Flange size (mm)
let bolt_square = 70.0; // [45.0, 130.0] Bolt hole square (mm)
let bolt_hole = 12.0; // [6.0, 20.0] Bolt hole diameter (mm)
let flange_thickness = 14.0; // [8.0, 25.0] Flange thickness (mm)
const housing_depth = 27.0;
const insert_od = 52.0;
const insert_width = 34.1;
let bs = min(bolt_square, flange_size - bolt_hole - 8.0);
let flange = box_centered(flange_size, flange_size, flange_thickness).translate([0, 0, flange_thickness / 2.0]).fillet(flange_size * 0.12, "|Z");
let boss = cylinder([0, 0, flange_thickness - 0.01], "Z", insert_od / 2.0 + 6.0, housing_depth - flange_thickness + 0.01);
let housing = flange + boss;
let holes = [];
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { holes.push(cylinder([x * bs / 2.0, y * bs / 2.0, -1], "Z", bolt_hole / 2.0, flange_thickness + 2.0)); } }
housing = housing - compound(holes) - cylinder([0, 0, -1], "Z", insert_od / 2.0 + 0.05, housing_depth + 2.0);
housing = housing.chamfer(0.8, "%CIRCLE and >Z and not %LINE");
let z0 = housing_depth / 2.0 - insert_width / 2.0;
let insert = cylinder([0, 0, z0], "Z", insert_od / 2.0, insert_width) - cylinder([0, 0, z0 - 1.0], "Z", shaft / 2.0, insert_width + 2.0);
compound([housing, insert])
