// Mushroom cabinet knob: 28 mm cap 23 mm tall on a 10 mm neck, 14 mm base, M4 tapped 10 mm deep
let cap = 14.0; // [10.0, 20.0] Cap radius (mm)
let h = 23.0; // [18.0, 35.0] Height (mm)
// the cap is a sphere segment centred on the axis, so the top is smooth
let z1 = h * 0.65;
let c = (h * h - z1 * z1 - cap * cap) / (2.0 * (h - z1));
let R = h - c;
let mx = cap * 0.55;
let k = sketch("XZ").move_to(0, 0).line_to(7.0, 0).line_to(7.0, 2.0).line_to(5.0, h * 0.39).line_to(cap, z1).arc_to(mx, c + sqrt(R * R - mx * mx), 0, h).close();
k.to_face().revolve("Z", 360) - cylinder([0, 0, -1], "Z", 1.65, 11.0)
