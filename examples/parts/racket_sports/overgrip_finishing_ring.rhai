// Overgrip finishing ring: 28 mm ID, 1.2 mm wall, 12 mm wide elastic-style band with a 0.6 mm inner grip lip at each edge and a 10 x 5 mm logo tab
let id = 28.0; // [24.0, 34.0] Handle diameter (mm)
let width = 12.0; // [8.0, 16.0] Band width (mm)
const wall = 1.2;
let band = cylinder([0, 0, 0], "Z", id / 2.0 + wall, width) - cylinder([0, 0, -1.0], "Z", id / 2.0, width + 2.0);
let lips = (cylinder([0, 0, 0], "Z", id / 2.0 + 0.01, 1.0) - cylinder([0, 0, -1.0], "Z", id / 2.0 - 0.6, 3.0)) + (cylinder([0, 0, width - 1.0], "Z", id / 2.0 + 0.01, 1.0) - cylinder([0, 0, width - 2.0], "Z", id / 2.0 - 0.6, 3.0));
let tab = box_from_corners([-5.0, id / 2.0 + wall - 0.5, width / 2.0 - 2.5], [5.0, id / 2.0 + wall + 1.0, width / 2.0 + 2.5]);
band + lips + tab
