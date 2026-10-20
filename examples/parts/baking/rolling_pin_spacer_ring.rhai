// Rolling pin thickness ring: fits a 50 mm pin, 6 mm dough thickness (62 mm OD), 10 mm wide
let pin = 50.0; // [35.0, 65.0] Rolling pin diameter (mm)
let thickness = 6.0; // [2.0, 15.0] Dough thickness (mm)
let width = 10.0; // [6.0, 15.0] Ring width (mm)
let ring = cylinder(pin / 2.0 + thickness, width) - cylinder([0, 0, -1], "Z", pin / 2.0 + 0.3, width + 2.0);
let r = ring.chamfer(1.0, ring.edges("%CIRCLE").filter(|e| e.radius() > pin / 2.0 + 1.0));
r
