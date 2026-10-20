// Lamp base weight cup: 130 mm dish 25 mm tall with 3 mm walls to hold steel or sand ballast, a 10.5 mm centre rod hole, a 12 mm cord exit notch and a 3 mm lip for a felt base
let dia = 130.0; // [90.0, 200.0] Base diameter (mm)
let height = 25.0; // [15.0, 40.0] Base height (mm)
const wall = 3.0;
let c = cylinder([0, 0, 0], "Z", dia / 2.0, height) - cylinder([0, 0, -1.0], "Z", dia / 2.0 - wall, height - wall + 1.0);
let lip = cylinder([0, 0, 0], "Z", dia / 2.0 - wall + 0.01, 3.0) - cylinder([0, 0, -1.0], "Z", dia / 2.0 - wall - 2.0, 5.0);
let boss = cylinder([0, 0, 0], "Z", 10.0, height);
c + lip + boss - cylinder([0, 0, -1.0], "Z", 5.25, height + 2.0) - box_centered(12.0, 20.0, 10.0).translate([0, -dia / 2.0 + 5.0, 3.0])
