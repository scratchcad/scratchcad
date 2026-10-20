// 1:100 architectural model tree: 8 m tree as 80 mm tall model, 2 mm trunk 30 mm tall, 40 mm faceted crown from two stacked cones, on a 10 mm base disc 1 mm
let height = 80.0; // [40.0, 150.0] Model tree height (mm)
let crown = 40.0; // [20.0, 70.0] Crown diameter (mm)
let trunk_h = height * 0.375;
let base = cylinder([0, 0, 0], "Z", 5.0, 1.0);
let trunk = cylinder([0, 0, 0.99], "Z", 1.0, trunk_h);
let c1 = cone(crown / 2.0, crown * 0.3, (height - trunk_h) * 0.55).translate([0, 0, trunk_h]);
let c2 = cone(crown * 0.38, 0.5, (height - trunk_h) * 0.5).translate([0, 0, trunk_h + (height - trunk_h) * 0.5]);
base + trunk + c1 + c2
