// Flanged bronze bushing ISO 4379 F 16 x 22 x 30 x 15: 16 mm bore, 22 mm OD, 30 mm flange 3 mm thick, 15 mm overall length, 0.5 mm chamfers
let bore = 16.0; // [6.0, 50.0] Bore diameter (mm)
let outer_diameter = 22.0; // [9.0, 60.0] Outer diameter (mm)
let flange_diameter = 30.0; // [12.0, 80.0] Flange diameter (mm)
let flange_thickness = 3.0; // [1.8, 8.0] Flange thickness (mm)
let length = 15.0; // [5.0, 60.0] Overall length (mm)
let ri = bore / 2.0;
let ro = max(outer_diameter / 2.0, ri + 1.5);
let rf = max(flange_diameter / 2.0, ro + 2.0);
let ft = min(flange_thickness, length - 2.0);
let profile = polygon([[ri, 0, 0], [rf, 0, 0], [rf, 0, ft], [ro, 0, ft], [ro, 0, length], [ri, 0, length]]);
let bush = profile.to_face().revolve("Z", 360);
bush.chamfer(min(0.5, (ro - ri) * 0.3), "%CIRCLE and not (>Z[1])")
