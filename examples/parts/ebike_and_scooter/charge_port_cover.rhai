// E-bike charge port rubber-style cover: 16 mm plug 8 mm deep, 22 mm cap 3 mm, tether strap 25 x 4 mm with an 8 mm ring
let plug = 16.0; // [10.0, 25.0] Port diameter (mm)
let depth = 8.0; // [5.0, 12.0] Plug depth (mm)
let cap = 22.0; // [15.0, 30.0] Cap diameter (mm)
let c = cylinder(cap / 2.0, 3.0) + cylinder([0, 0, -depth], "Z", plug / 2.0, depth + 0.01) + cylinder([0, 0, -depth + 2.0], "Z", plug / 2.0 + 0.6, 1.2);
let strap = box_from_corners([cap / 2.0 - 2.0, -2.0, 0], [cap / 2.0 + 25.0, 2.0, 1.5]);
let ring = cylinder([cap / 2.0 + 25.0 + 3.0, 0, 0], "Z", 5.0, 1.5) - cylinder([cap / 2.0 + 25.0 + 3.0, 0, -1], "Z", 3.0, 3.5);
c + strap + ring - cylinder([0, 0, -depth - 1.0], "Z", plug / 2.0 - 1.5, depth)
