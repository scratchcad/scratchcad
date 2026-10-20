// Pillar candle mould: 70 mm ID tube 150 mm tall with 2.5 mm wall, a 1 degree taper inside (70 to 67.4 mm) for release, a 3 mm wick hole in the closed end and a 90 mm pour flange
let dia = 70.0; // [40.0, 100.0] Candle diameter at the top (mm)
let height = 150.0; // [60.0, 250.0] Candle height (mm)
const wall = 2.5;
let taper = height * 0.0175;
let outer = cylinder([0, 0, 0], "Z", dia / 2.0 + wall, height + wall);
let inner = cone(dia / 2.0 - taper / 2.0, dia / 2.0, height + 0.02).translate([0, 0, wall]);
let flange = cylinder([0, 0, height + wall - 3.0], "Z", dia / 2.0 + 10.0, 3.0);
outer + flange - inner - cylinder([0, 0, -1.0], "Z", 1.5, wall + 2.0)
