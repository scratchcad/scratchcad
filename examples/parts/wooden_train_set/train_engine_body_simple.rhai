// Wooden toy locomotive body: 80 x 32 x 30 mm block with a 25 mm boiler, 15 mm chimney, cab 25 x 32 x 20 mm, 2 axle holes 4.5 mm
let length = 80.0; // [60.0, 120.0] Body length (mm)
let width = 32.0; // [25.0, 40.0] Width (mm)
let chassis = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, 12.0]);
let boiler = cylinder([0, 0, 12.0 + 11.0], "X", 12.5, length - 25.0);
let cab = box_from_corners([length - 25.0, -width / 2.0, 11.99], [length, width / 2.0, 42.0]) - box_from_corners([length - 20.0, -width, 28.0], [length - 5.0, width, 38.0]);
let roof = box_from_corners([length - 27.0, -width / 2.0 - 2.0, 41.99], [length + 2.0, width / 2.0 + 2.0, 45.0]);
let chimney = cylinder([12.0, 0, 30.0], "Z", 6.0, 15.0) + cylinder([12.0, 0, 43.0], "Z", 7.5, 3.0);
chassis + boiler + cab + roof + chimney - cylinder([15.0, -width, 5.0], "Y", 2.25, width * 2.0) - cylinder([length - 15.0, -width, 5.0], "Y", 2.25, width * 2.0)
