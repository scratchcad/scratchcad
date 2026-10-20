// E3D V6 heater block: 16 x 23 x 11.5 mm, 6 mm heater cartridge bore, 3 mm thermistor bore, M6 nozzle hole, clamp slit with M3 screw
let width = 16.0; // [12.0, 25.0] Width (mm)
let length = 23.0; // [18.0, 30.0] Length (mm)
let height = 11.5; // [8.0, 15.0] Height (mm)
let block = box(length, width, height);
block = block - cylinder([4.5, width / 2.0, -1], "Z", 2.55, height + 2.0);
block = block - cylinder([length - 6.0, -1, height / 2.0], "Y", 3.05, width + 2.0);
block = block - cylinder([10.5, -1, 2.5], "Y", 1.5, width + 2.0);
block = block - box_from_corners([length - 6.0, width / 2.0 - 0.5, -1], [length + 1, width / 2.0 + 0.5, height + 1]);
block - cylinder([length - 2.0, -1, height - 2.5], "Y", 1.25, width + 2.0)
