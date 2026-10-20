// Fermenter lid airlock grommet: fits a 12.5 mm lid hole in 2 mm plastic, 9.5 mm airlock stem bore, 18 mm flange
let hole = 12.5; // [10.0, 16.0] Lid hole (mm)
let stem = 9.5; // [8.0, 11.0] Airlock stem (mm)
let lid = 2.0; // [1.0, 4.0] Lid thickness (mm)
let g = cylinder(9.0, 2.0) + cylinder([0, 0, -lid], "Z", hole / 2.0, lid + 0.01) + cone(hole / 2.0 + 1.0, hole / 2.0 - 0.3, 3.0).translate([0, 0, -lid - 3.0 + 0.01]);
g - cylinder([0, 0, -lid - 4.0], "Z", stem / 2.0 - 0.3, lid + 7.0)
