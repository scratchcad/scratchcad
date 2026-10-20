// Scooter folding latch hook: 40 x 20 mm hook plate 5 mm, 8 mm pivot hole, 10 mm hook throat for a 6 mm fender pin
let length = 40.0; // [30.0, 60.0] Hook length (mm)
let width = 20.0; // [15.0, 30.0] Plate height (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let pin = 6.0; // [4.0, 10.0] Catch pin (mm)
let plate = polygon([[0, 0], [length, 0], [length, width], [length - 6.0, width], [length - 6.0, pin + 2.0], [length - 6.0 - pin - 1.0, pin + 2.0], [length - 6.0 - pin - 1.0, width], [0, width]]).to_face().extrude([0, 0, t]);
plate - cylinder([8.0, width / 2.0, -1], "Z", 4.0, t + 2.0)
