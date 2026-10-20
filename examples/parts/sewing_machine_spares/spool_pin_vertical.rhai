// Vertical spool pin: 6 mm pin 55 mm tall with a 1 mm chamfered tip, 12 mm collar 3 mm thick, M5 threaded stub (plain 5 mm cylinder) 8 mm long below the collar
let pin_len = 55.0; // [30.0, 80.0] Pin length (mm)
let pin_d = 6.0; // [4.0, 8.0] Pin diameter (mm)
let collar_d = 12.0; // [9.0, 18.0] Collar diameter (mm)
let stub_len = 8.0; // [5.0, 12.0] Threaded stub length (mm)
const collar_t = 3.0;
const stub_d = 5.0;
let cd = max(collar_d, pin_d + 3.0);
let pin = cylinder([0, 0, collar_t - 0.5], "Z", pin_d / 2.0, pin_len + 0.5);
let pin = pin.chamfer(1.0, pin.edges(">Z"));
let collar = cylinder(cd / 2.0, collar_t);
let collar = collar.chamfer(0.5, collar.edges(">Z or <Z"));
let stub = cylinder([0, 0, -stub_len], "Z", stub_d / 2.0, stub_len + 0.5);
let stub = stub.chamfer(0.4, stub.edges("<Z"));
fuse_all([pin, collar, stub])
