// Quickdraw rubber keeper: 22 x 14 mm band 10 mm long holding the carabiner basket against a 22 mm sling, 12 mm carabiner bar hole and 1.5 mm walls
let sling = 22.0; // [11.0, 26.0] Sling width (mm)
let bar = 12.0; // [9.0, 14.0] Carabiner bar diameter (mm)
const wall = 1.5;
const length = 10.0;
let band = box_centered(sling + 2.0 * wall, 3.0 + 2.0 * wall, length) - box_centered(sling, 3.0, length + 2.0);
let loop_ = cylinder([0, 1.5 + wall + bar / 2.0 - 0.5, -length / 2.0], "Z", bar / 2.0 + wall, length) - cylinder([0, 1.5 + wall + bar / 2.0 - 0.5, -length / 2.0 - 1.0], "Z", bar / 2.0, length + 2.0);
band + loop_ - box_centered(sling, 3.0, length + 2.0)
