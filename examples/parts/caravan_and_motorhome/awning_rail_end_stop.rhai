// Awning keder rail end stop: 30 mm plug for a 12 mm C-rail with a 7 mm slot, 8 mm wide neck, a 20 x 20 x 4 mm end flange and a 3.5 mm screw hole
let rail = 12.0; // [10.0, 16.0] Rail channel diameter (mm)
let length = 30.0; // [20.0, 50.0] Plug length (mm)
const neck = 6.5;
let plug = cylinder([0, 0, 0], "Z", rail / 2.0 - 0.3, length);
let web = box_from_corners([-neck / 2.0, 0, 0], [neck / 2.0, rail / 2.0 + 4.0, length]);
let flange = box_from_corners([-10.0, -rail / 2.0 - 2.0, -4.0], [10.0, rail / 2.0 + 10.0, 0.01]);
plug + web + flange - cylinder([0, rail / 2.0 + 6.0, -5.0], "Z", 1.75, 6.0)
