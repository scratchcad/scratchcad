// Place card / price card stand: 40 mm wedge base 15 mm tall with a 1.2 mm angled card slot at 75 degrees
let width = 40.0; // [20.0, 80.0] Width (mm)
let depth = 25.0; // [15.0, 40.0] Depth (mm)
let height = 15.0; // [8.0, 25.0] Height (mm)
let slot = 1.2; // [0.5, 3.0] Card slot (mm)
let base = polygon([[0, 0], [depth, 0], [depth * 0.65, height], [depth * 0.25, height]]).to_face().extrude([0, 0, width]).rotate_x(90.0).translate([0, width, 0]);
let cut = box_from_corners([-slot / 2.0, -1.0, 4.0], [slot / 2.0, width + 1.0, height * 3.0]).rotate([0, 0, 4.0], "Y", -15.0).translate([depth * 0.42, 0, 0]);
base - cut
