// Boiler flue wall rosette for 100 mm concentric flue: 150 mm plate 3 mm thick, 101 mm bore, 15 mm raised collar 2 mm wall, 45 degree outer edge chamfer
let flue = 100.0; // [60.0, 125.0] Flue diameter (mm)
let plate_d = 150.0; // [100.0, 200.0] Rosette diameter (mm)
let thick = 3.0; // [2.0, 5.0] Plate thickness (mm)
let collar_h = 15.0; // [5.0, 30.0] Collar height (mm)
let rb = flue / 2.0 + 0.5;
let rp = max(plate_d / 2.0, rb + 10.0);
let pts = [[rb, 0, 0], [rp, 0, 0], [rp, 0, thick * 0.4], [rp - thick * 0.6, 0, thick], [rb + 2.0, 0, thick], [rb + 2.0, 0, thick + collar_h], [rb, 0, thick + collar_h]];
polygon(pts).to_face().revolve("Z", 360)
