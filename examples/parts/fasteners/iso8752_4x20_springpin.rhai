// ISO 8752 4 x 20 slotted spring pin: 4 mm OD, 0.8 mm wall, slot along its length
let diameter = 4.0; // [1.0, 16.0] Outside diameter (mm)
let length = 20.0; // [4.0, 100.0] Length (mm)
let wall = 0.8; // [0.2, 3.0] Wall thickness (mm)
let slot = 0.8; // [0.3, 3.0] Slot width (mm)
let tube = cylinder(diameter / 2.0, length) - cylinder([0, 0, -1], "Z", diameter / 2.0 - wall, length + 2.0);
(tube - box_centered(slot, diameter, length + 2.0).translate([0, diameter / 2.0, length / 2.0])).chamfer(wall * 0.3, "%CIRCLE and (>Z or <Z)")
