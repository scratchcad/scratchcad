// Spring toilet roll spindle: 20 mm outer tube 100 mm with 24 mm end cap and 8 mm pin, 17 mm inner tube 60 mm with its own cap
let len = 100.0; // [80.0, 140.0] Outer tube length (mm)
let outer = fuse_all([cylinder([0, 0, 0], "X", 10.0, len), cylinder([-5.0, 0, 0], "X", 12.0, 5.0), cylinder([-13.0, 0, 0], "X", 4.0, 8.0)]) - cylinder([10.0, 0, 0], "X", 9.0, len);
let inner = fuse_all([cylinder([len - 40.0, 0, 0], "X", 8.5, 60.0), cylinder([len + 20.0, 0, 0], "X", 12.0, 5.0), cylinder([len + 25.0, 0, 0], "X", 4.0, 8.0)]) - cylinder([len - 41.0, 0, 0], "X", 7.0, 50.0);
compound([outer, inner])
