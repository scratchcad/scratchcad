// Pipe U-bolt saddle plate for 25 mm OD pipe, M6 U-bolt: 50 x 20 x 6 mm with 12.5 mm radius seat and 6.6 mm holes on 32 mm
let pipe = 25.0; // [12.0, 60.0] Pipe OD (mm)
let length = 50.0; // [30.0, 100.0] Plate length (mm)
let width = 20.0; // [12.0, 30.0] Plate width (mm)
let t = 8.0; // [5.0, 12.0] Plate thickness (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
plate - cylinder([0, -width, t + pipe / 2.0 - 3.0], "Y", pipe / 2.0, width * 2.0) - cylinder([-(pipe + 7.0) / 2.0, 0, -1], "Z", 3.3, t + 2.0) - cylinder([(pipe + 7.0) / 2.0, 0, -1], "Z", 3.3, t + 2.0)
