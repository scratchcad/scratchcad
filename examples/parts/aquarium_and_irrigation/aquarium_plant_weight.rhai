// Aquarium plant weight: 40 mm lead-free ring 6 mm thick split ring, 12 mm opening
let od = 40.0; // [25.0, 60.0] Outside diameter (mm)
let width = 8.0; // [5.0, 12.0] Ring width (mm)
let thickness = 6.0; // [3.0, 10.0] Thickness (mm)
let gap = 12.0; // [6.0, 20.0] Opening (mm)
let ring = cylinder(od / 2.0, thickness) - cylinder([0, 0, -1], "Z", od / 2.0 - width, thickness + 2.0);
let r = ring - box_from_corners([od / 2.0 - width - 2.0, -gap / 2.0, -1], [od / 2.0 + 1.0, gap / 2.0, thickness + 1.0]);
r.fillet(1.0, r.edges("%CIRCLE"))
