// Slotted spring pin ISO 8752 5 x 30, heavy duty: 5.3 mm free diameter, 1.0 mm wall, 1.2 mm slot along the length, 30 mm long, both ends chamfered
let diameter = 5.3; // [1.2, 21.0] Free outer diameter (mm)
let length = 30.0; // [4.0, 120.0] Length (mm)
let wall = 1.0; // [0.2, 4.0] Wall thickness (mm)
let slot = 1.2; // [0.3, 4.0] Slot width (mm)
let r = diameter / 2.0;
let w = min(wall, r * 0.45);
let pin = polygon([[r - w, 0, 0], [r - 0.4, 0, 0], [r, 0, 0.8], [r, 0, length - 0.8], [r - 0.4, 0, length], [r - w, 0, length]]).to_face().revolve("Z", 360);
pin - box_from_corners([0, -slot / 2.0, -1], [r + 1.0, slot / 2.0, length + 1.0])
