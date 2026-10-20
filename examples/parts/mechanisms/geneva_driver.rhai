// Geneva driver for a 4-slot wheel: 21.2 mm crank with 6 mm pin, 15.2 mm locking disc with wheel clearance cut
let crank = 21.2; // [10.0, 40.0] Crank radius (mm)
let pin = 6.0; // [3.0, 10.0] Pin diameter (mm)
let thickness = 8.0; // [4.0, 15.0] Thickness (mm)
let bore = 8.0; // [4.0, 15.0] Bore (mm)
let c = crank * 2.0.sqrt();
let wheel_r = (c * c - crank * crank).sqrt() + pin / 2.0;
let lock_r = crank - pin;
let arm = box_from_corners([0, -6.0, 0], [crank, 6.0, thickness / 2.0]) + cylinder([crank, 0, 0], "Z", 6.0, thickness / 2.0);
let lock = cylinder([0, 0, thickness / 2.0 - 0.01], "Z", lock_r, thickness / 2.0 + 0.01) - cylinder([c, 0, -1], "Z", wheel_r + 0.5, thickness * 2.0);
let p = cylinder([crank, 0, thickness / 2.0 - 0.01], "Z", pin / 2.0, thickness / 2.0 + 0.01);
let hub = cylinder(9.0, thickness / 2.0);
arm + hub + lock + p - cylinder([0, 0, -1], "Z", bore / 2.0, thickness * 2.0)
