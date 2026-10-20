// Tapered face-grain wood plug for a 10 mm counterbore: 10.2 to 9.6 mm over 8 mm, domed top
let d = 10.0; // [6.0, 20.0] Counterbore diameter (mm)
let length = 8.0; // [5.0, 15.0] Plug length (mm)
cone(d / 2.0 - 0.2, d / 2.0 + 0.1, length) + (sphere([0, 0, length - 4.5], 6.0) & cylinder([0, 0, length - 0.01], "Z", d / 2.0 + 0.1, 1.5))
