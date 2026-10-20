// Speaker pole adapter: 35 mm (1 3/8 in) top-hat pin 100 mm long to an M10 eyebolt boss, 34.8 mm pin with a 3 mm lead chamfer, 60 mm collar 12 mm thick, 8.5 mm tapping bore 20 mm deep
let pin = 34.8; // [34.0, 35.0] Pin diameter (mm)
let pin_length = 100.0; // [60.0, 150.0] Pin length (mm)
let collar = 60.0; // [45.0, 80.0] Collar diameter (mm)
let collar_height = 12.0; // [8.0, 20.0] Collar height (mm)
let p = polygon("XZ", [[0, 0], [pin / 2.0 - 3.0, 0], [pin / 2.0, 3.0], [pin / 2.0, pin_length], [collar / 2.0, pin_length], [collar / 2.0, pin_length + collar_height - 2.0], [collar / 2.0 - 2.0, pin_length + collar_height], [0, pin_length + collar_height]]);
let body = p.to_face().revolve([0, 0, 0], "Z", 360);
// lightening bore from below and the tapping bore from the top
body - cylinder([0, 0, -1.0], "Z", pin / 2.0 - 5.0, pin_length - 10.0) - cylinder([0, 0, pin_length + collar_height - 20.0], "Z", 4.25, 21.0) - cylinder([-collar, 0, pin_length + collar_height / 2.0], "X", 2.5, collar * 2.0)
