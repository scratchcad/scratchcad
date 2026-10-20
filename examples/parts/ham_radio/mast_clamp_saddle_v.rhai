// Antenna mast V-saddle clamp: fits 25 to 50 mm masts, 70 x 40 x 15 mm block with a 90 degree V and 2 x 8.5 mm U-bolt holes 56 mm apart
let width = 70.0; // [50.0, 100.0] Saddle width (mm)
let depth = 40.0; // [25.0, 60.0] Saddle depth (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let pitch = 56.0; // [40.0, 80.0] U-bolt spacing (mm)
let b = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let groove = polygon([[-height * 0.9, -depth, height + 0.01], [height * 0.9, -depth, height + 0.01], [0, -depth, 3.0]]).to_face().extrude([0, depth * 2.0, 0]);
b - groove - cylinder([-pitch / 2.0, 0, -1], "Z", 4.25, height + 2.0) - cylinder([pitch / 2.0, 0, -1], "Z", 4.25, height + 2.0)
