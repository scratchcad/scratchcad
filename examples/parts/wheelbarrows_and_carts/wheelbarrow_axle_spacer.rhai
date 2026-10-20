// Wheelbarrow axle spacer: 25 mm OD spacer 40 mm long for a 5/8 inch (15.9 mm) axle, 16.3 mm bore and 1 mm end chamfers
let length = 40.0; // [10.0, 80.0] Spacer length (mm)
let od = 25.0; // [22.0, 35.0] Spacer OD (mm)
let s = cylinder([0, 0, 0], "Z", od / 2.0, length) - cylinder([0, 0, -1.0], "Z", 8.15, length + 2.0);
s.chamfer(1.0, s.edges("%CIRCLE and (>Z or <Z)"))
