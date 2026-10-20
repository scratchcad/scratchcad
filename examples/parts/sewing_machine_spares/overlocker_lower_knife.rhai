// Overlocker lower knife: 19 x 6 mm steel blade 8 mm tall with a 20 degree cutting bevel on the top front edge, 3.2 mm mounting hole through the side 3 mm above the base, 0.5 mm back edge chamfer
let length = 19.0; // [14.0, 26.0] Blade length (mm)
let thickness = 6.0; // [4.0, 8.0] Blade thickness (mm)
let height = 8.0; // [6.0, 12.0] Blade height (mm)
let bevel = 20.0; // [10.0, 35.0] Bevel angle (degrees)
let drop = thickness * tan(bevel * PI() / 180.0);
let drop = min(drop, height - 4.0);
let side = polygon([[0, 0, 0], [0, thickness, 0], [0, thickness, height - drop], [0, 0, height]]).to_face().extrude([length, 0, 0]);
let side = side.chamfer(0.5, side.edges("|X and >Y and <Z"));
side - cylinder([length / 2.0, -1.0, 3.0], "Y", 1.6, thickness + 2.0)
