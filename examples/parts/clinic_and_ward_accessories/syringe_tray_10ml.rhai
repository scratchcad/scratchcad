// Drug preparation syringe tray: 10 grooves for 10 ml syringes (16.5 mm barrels) at 24 mm pitch in a 250 x 100 x 15 mm tray, 9 mm deep cradles and a 4 mm raised rim at the plunger end
let count = 10; // [4, 14] Number of syringes
let barrel = 16.5; // [12.0, 22.0] Barrel diameter (mm)
let length = 100.0; // [80.0, 160.0] Tray depth (mm)
const pitch = 24.0;
const h = 15.0;
let w = count.to_float() * pitch + 10.0;
let tray = box_from_corners([0, 0, 0], [w, length, h]) + box_from_corners([0, length - 6.0, h - 0.01], [w, length, h + 4.0]);
let grooves = [];
for i in 0..count {
    grooves.push(cylinder([5.0 + pitch * (i.to_float() + 0.5), -1.0, h + barrel / 2.0 - 9.0], "Y", barrel / 2.0 + 0.5, length - 5.0));
}
tray - compound(grooves)
