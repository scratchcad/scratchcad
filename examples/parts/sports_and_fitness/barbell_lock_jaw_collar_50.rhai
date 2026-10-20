// Lock-jaw style Olympic barbell collar for 50 mm sleeves: 50.6 mm bore, 82 mm OD ring 38 mm wide, 3 mm clamp split under a 30 mm lever housing, 70 mm cam lever
let bore_d = 50.6; // [25.6, 52.0] Bore for the bar sleeve (mm)
let outer_d = 82.0; // [60.0, 100.0] Ring outer diameter (mm)
let width = 38.0; // [25.0, 50.0] Collar width (mm)
let split = 3.0; // [1.5, 5.0] Clamp split width (mm)
let lever_length = 70.0; // [40.0, 100.0] Lever length (mm)
let ro = max(outer_d, bore_d + 16.0) / 2.0;
let ring = cylinder(ro, width) - cylinder([0, 0, -1.0], "Z", bore_d / 2.0, width + 2.0);
ring = ring.chamfer(1.0, ring.edges("%CIRCLE").filter(|e| e.radius() < bore_d / 2.0 + 0.1));
let housing = box_from_corners([-15.0, ro - 5.0, 0], [15.0, ro + 12.0, width]).fillet(6.0, "|Z and >Y");
let collar = ring + housing;
collar = collar - box_from_corners([-split / 2.0, 0, -1.0], [split / 2.0, ro + 13.0, width + 1.0]);
// hinge pin across the split and the lever lying along the ring
collar = collar - cylinder([-20.0, ro + 5.0, width / 2.0], "X", 2.5, 40.0);
let lever = box_from_corners([-lever_length + 12.0, ro + 12.0, width / 2.0 - 7.0], [12.0, ro + 20.0, width / 2.0 + 7.0]).fillet(3.5, "|Y");
collar + lever
