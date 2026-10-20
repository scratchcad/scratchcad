// Hardened dowel pin ISO 8734 6 x 20 (m6 tolerance): 6 mm diameter, 20 mm long, one end chamfered 15 deg for 1 mm, the other end with a 0.6 mm radius
let diameter = 6.0; // [1.0, 25.0] Pin diameter (mm)
let length = 20.0; // [3.0, 100.0] Length (mm)
let chamfer_length = 1.0; // [0.2, 3.0] Lead chamfer length (mm)
let end_radius = 0.6; // [0.1, 2.5] Rounded end radius (mm)
let r = diameter / 2.0;
let cl = min(chamfer_length, length * 0.2);
let cr = cl * (15.0 * PI() / 180.0).tan();
let pin = polygon([[0, 0, 0], [r - cr, 0, 0], [r, 0, cl], [r, 0, length], [0, 0, length]]).to_face().revolve("Z", 360);
pin.fillet(min(end_radius, r * 0.4), ">Z")
