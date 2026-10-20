// Stainless bow shackle, assembled: 5 mm bow wire, 16 mm jaw, 37 mm inside length, eyes 11 mm across with an M6 screw pin and 12 mm head
let jaw = 16.0; // [10.0, 30.0] Jaw width between the eyes (mm)
let inside_length = 37.0; // [25.0, 60.0] Inside length (mm)
let wire = 5.0; // [3.0, 8.0] Bow wire diameter (mm)
let pin_diameter = 6.0; // [4.0, 10.0] Pin diameter (mm)
let r = wire / 2.0;
let x = jaw / 2.0 + r;
let L = inside_length;
let path = spline([[x, 0, 0], [x, 0, L * 0.25], [x + L * 0.08, 0, L * 0.6], [x, 0, L * 0.85], [0, 0, L + r], [-x, 0, L * 0.85],
                   [-x - L * 0.08, 0, L * 0.6], [-x, 0, L * 0.25], [-x, 0, 0]]);
let tangent = path.tangent_at(0.0);
let bow = circle([x, 0, 0], tangent, r).to_face().sweep(wire([path]));
let rp = pin_diameter / 2.0;
let re = rp + 2.5;
let eyes = [];
for s in [-1.0, 1.0] {
    eyes.push(cylinder([s * x - wire * 0.55, 0, -re + 1.0], "X", re, wire * 1.1));
}
let body = fuse_all([bow] + eyes) - cylinder([-x - wire, 0, -re + 1.0], "X", rp + 0.3, 2.0 * x + 2.0 * wire);
let pin = cylinder([-x - wire * 0.55 - 3.5, 0, -re + 1.0], "X", rp + 3.0, 3.0) + cylinder([-x - wire * 0.55 - 0.6, 0, -re + 1.0], "X", rp, 2.0 * x + wire * 1.1 + 2.5);
compound([body, pin])
