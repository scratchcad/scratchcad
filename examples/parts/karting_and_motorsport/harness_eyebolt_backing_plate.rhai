// Race harness eye-bolt backing plate to FIA 8853 practice: 70 x 60 x 3 mm steel plate (42 sq cm) with 8 mm corner chamfers, an 11.5 mm hole for the 7/16-20 UNF eye bolt and a 1 mm chamfer on the hole
let length = 70.0; // [60.0, 100.0] Plate length (mm)
let width = 60.0; // [55.0, 80.0] Plate width (mm)
let thickness = 3.0; // [3.0, 6.0] Plate thickness (mm)
let bolt_hole = 11.5; // [11.2, 13.0] Bolt hole diameter (mm)
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.chamfer(8.0, plate.edges("|Z"));
let hole = cylinder([0, 0, -1.0], "Z", bolt_hole / 2.0, thickness + 2.0) + cone(bolt_hole / 2.0, bolt_hole / 2.0 + 2.0, 2.0).translate([0, 0, thickness - 0.99]);
let p = plate - hole;
print(`area ${length * width - 4.0 * 32.0} sq mm`);
p
