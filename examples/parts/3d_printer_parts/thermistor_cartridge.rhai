// Thermistor cartridge: 3 mm x 15 mm stainless tube with a 1 mm lead bundle exiting and a 4 mm strain-relief sleeve
let diameter = 3.0; // [2.0, 6.0] Diameter (mm)
let length = 15.0; // [8.0, 25.0] Length (mm)
let tube = cylinder(diameter / 2.0, length).chamfer(0.3, "<Z");
let sleeve = cylinder([0, 0, length - 0.01], "Z", 2.0, 6.0);
let leads = cylinder([0, 0, length + 5.0], "Z", 0.5, 25.0);
fuse_all([tube, sleeve, leads])
