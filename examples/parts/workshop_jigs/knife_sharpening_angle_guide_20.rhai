// Knife sharpening angle guide, 20 degrees: 45 x 25 mm wedge rising at 20 degrees to a 5 mm flat, 10 x 3 mm magnet pocket in the base
let angle = 20.0; // [10.0, 30.0] Sharpening angle (degrees)
let length = 40.0; // [25.0, 60.0] Slope length (mm)
let width = 25.0; // [15.0, 40.0] Guide width (mm)
let magnet_d = 10.0; // [6.0, 15.0] Magnet pocket diameter (mm)
let h = length * (angle * PI() / 180.0).tan();
let wedge = polygon([[0, 0, 0], [length + 5.0, 0, 0], [length + 5.0, 0, h], [length, 0, h]]).to_face().extrude([0, width, 0]);
wedge - cylinder([length * 0.75, width / 2.0, -1], "Z", magnet_d / 2.0, 4.0)
