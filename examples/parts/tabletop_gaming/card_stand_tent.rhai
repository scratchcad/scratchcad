// Game card display stand: 80 mm wide, 20 degree lean, 2 mm card slot, 10 mm tall wedge base 25 mm deep
let width = 80.0; // [40.0, 120.0] Width (mm)
let depth = 25.0; // [15.0, 40.0] Base depth (mm)
let height = 10.0; // [6.0, 20.0] Base height (mm)
let slot = 2.0; // [1.0, 4.0] Slot width (mm)
let base = polygon([[0, 0, 0], [depth, 0, 0], [depth * 0.7, 0, height], [depth * 0.2, 0, height]]).to_face().extrude([0, width, 0]);
base - box_from_corners([-slot / 2.0, -1, 3.0], [slot / 2.0, width + 1.0, height * 3.0]).rotate([0, 0, 3.0], "Y", -20.0).translate([depth * 0.45, 0, 0])
