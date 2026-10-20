// Geneva drive driver for a 4-slot wheel at 50 mm centres: 35.4 mm crank radius, 6 mm pin 12 mm tall, 26.4 mm locking disc 8 mm thick with relief cut, 5 mm base plate, 10 mm bore
let centre_distance = 50.0; // [30.0, 120.0] Centre distance to the wheel (mm)
let pin_diameter = 6.0; // [3.0, 12.0] Drive pin diameter (mm)
let plate_thickness = 5.0; // [2.0, 10.0] Base plate thickness (mm)
let disc_thickness = 8.0; // [3.0, 20.0] Locking disc thickness (mm)
let bore = 10.0; // [4.0, 20.0] Bore diameter (mm)
const slots = 4;
let half = PI() / slots.to_float();
let crank = centre_distance * half.sin();
let rw = centre_distance * half.cos();
let lock_r = crank - pin_diameter * 1.5;
let plate = cylinder(crank + pin_diameter * 1.2, plate_thickness);
let disc = cylinder([0, 0, plate_thickness - 0.01], "Z", lock_r, disc_thickness + 0.01);
let relief = cylinder([centre_distance, 0, plate_thickness - 1.0], "Z", rw + 0.5, disc_thickness + 2.0);
disc = disc - relief;
let pin = cylinder([crank, 0, plate_thickness - 0.01], "Z", pin_diameter / 2.0, disc_thickness + 4.0);
let part = fuse_all([plate, disc, pin]);
part = part - cylinder([0, 0, -1], "Z", bore / 2.0, plate_thickness + disc_thickness + 2.0);
part.chamfer(0.4, "%CIRCLE and >Z")
