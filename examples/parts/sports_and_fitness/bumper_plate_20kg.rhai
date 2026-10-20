// 20 kg Olympic bumper plate: 450 mm diameter, 85 mm thick rubber, 50.4 mm steel-hub bore, 4 mm face recess inside 380 mm, 120 mm raised hub land, 4 mm edge rounds
let diameter = 450.0; // [400.0, 450.0] Plate diameter (mm)
let thickness = 85.0; // [30.0, 110.0] Plate thickness (mm)
let bore_d = 50.4; // [50.0, 52.0] Bore (mm)
let recess_d = 380.0; // [250.0, 420.0] Face recess diameter (mm)
let hub_d = 120.0; // [80.0, 180.0] Hub land diameter (mm)
let recess = 4.0; // [0.0, 8.0] Face recess depth (mm)
let r = diameter / 2.0;
let rr = min(recess_d, diameter - 30.0) / 2.0;
let rh = min(hub_d, recess_d - 40.0) / 2.0;
let rec = min(recess, thickness / 4.0);
let prof = [[bore_d / 2.0, 0.0], [rh, 0.0], [rh + 4.0, rec], [rr - 4.0, rec], [rr, 0.0], [r, 0.0], [r, thickness], [rr, thickness], [rr - 4.0, thickness - rec], [rh + 4.0, thickness - rec], [rh, thickness], [bore_d / 2.0, thickness]];
let plate = polygon("XZ", prof).to_face().revolve("Z", 360);
plate = plate.fillet(4.0, plate.edges("%CIRCLE").filter(|e| e.radius() > r - 0.1));
plate.chamfer(1.5, plate.edges("%CIRCLE").filter(|e| e.radius() < bore_d / 2.0 + 0.1))
