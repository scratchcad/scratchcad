// Cabinet handle standoff spacer: 12 mm round spacer 8 mm tall with a 4.5 mm M4 bolt bore and a 1 mm locating spigot 6 mm dia on one face
let height = 8.0; // [3.0, 20.0] Spacer height (mm)
let od = 12.0; // [9.0, 18.0] Spacer OD (mm)
let s = cylinder([0, 0, 0], "Z", od / 2.0, height) + cylinder([0, 0, height - 0.01], "Z", 3.0, 1.0);
s - cylinder([0, 0, -1.0], "Z", 2.25, height + 3.0)
