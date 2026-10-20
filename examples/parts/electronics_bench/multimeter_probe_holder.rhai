// Multimeter probe holder: clips to a 6 mm shelf edge, two 9 mm probe holes 20 mm apart, 40 x 30 x 12 mm
let probe = 9.0; // [6.0, 14.0] Probe body (mm)
let pitch = 20.0; // [15.0, 30.0] Hole spacing (mm)
let shelf = 6.0; // [3.0, 25.0] Shelf thickness (mm)
let block = box_from_corners([-pitch / 2.0 - 10.0, 0, 0], [pitch / 2.0 + 10.0, 30.0, 12.0]);
let b = block.fillet(3.0, block.edges("|Z and >Y"));
let clip = box_from_corners([-10.0, -shelf - 6.0, 0], [10.0, 0.01, 12.0 + 15.0]) - box_from_corners([-11.0, -shelf - 3.0, 12.0], [11.0, -3.0, 30.0]);
b + clip - cylinder([-pitch / 2.0, 18.0, -1], "Z", probe / 2.0, 14.0) - cylinder([pitch / 2.0, 18.0, -1], "Z", probe / 2.0, 14.0)
