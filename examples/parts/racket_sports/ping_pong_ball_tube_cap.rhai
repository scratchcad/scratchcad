// Table tennis ball tube cap: fits a 41.5 mm ID tube for 40 mm balls, 46 mm OD cap 15 mm tall with a 10 mm plug spigot (41.2 mm) and a 6 mm belt-clip eye
let tube_id = 41.5; // [40.5, 44.0] Tube inside diameter (mm)
let height = 15.0; // [10.0, 25.0] Cap height (mm)
const wall = 2.0;
let cap = cylinder([0, 0, 0], "Z", tube_id / 2.0 + wall + 0.5, 5.0);
let spigot = cylinder([0, 0, -10.0], "Z", tube_id / 2.0 - 0.15, 10.01) - cylinder([0, 0, -11.0], "Z", tube_id / 2.0 - 0.15 - wall, 11.0);
let dome = cylinder([0, 0, 4.99], "Z", tube_id / 2.0 - 2.0, height - 5.0);
let eye = cylinder([0, -3.0, height + 2.0], "Y", 5.0, 6.0) - cylinder([0, -4.0, height + 2.0], "Y", 3.0, 8.0);
cap + spigot + dome + eye
