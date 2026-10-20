// Beach windbreak pole cap: 30 mm cap 20 mm tall for a 25 mm wooden pole with a 2 mm wall, a 10 mm guy-rope eye and a flat 8 mm mallet face on top
let pole = 25.0; // [18.0, 35.0] Pole diameter (mm)
let height = 20.0; // [15.0, 30.0] Cap height (mm)
const wall = 2.5;
let r = pole / 2.0 + 0.3;
let c = cylinder([0, 0, 0], "Z", r + wall, height + 8.0) - cylinder([0, 0, -1.0], "Z", r, height + 1.0);
let eye = cylinder([r + wall + 5.0, -3.0, height * 0.6], "Y", 8.0, 6.0) - cylinder([r + wall + 5.0, -4.0, height * 0.6], "Y", 5.0, 8.0) + box_from_corners([r + wall - 2.0, -3.0, height * 0.6 - 5.0], [r + wall + 1.0, 3.0, height * 0.6 + 5.0]);
c + eye
