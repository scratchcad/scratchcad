// Roof flashing for a 110 mm vent pipe: 300 x 300 mm base plate 2 mm laid at the roof pitch (30 degrees), vertical conical boot 2 mm wall rising 90 mm with a 111 mm bore for the pipe
let pipe_d = 111.0; // [50.0, 125.0] Pipe bore (mm)
let pitch = 30.0; // [0.0, 45.0] Roof pitch (degrees)
let plate = 300.0; // [300.0, 500.0] Base plate size (mm)
let boot_h = 90.0; // [60.0, 150.0] Boot height above the plate centre (mm)
const t = 2.0;
let rp = pipe_d / 2.0;
let tn = (pitch * PI() / 180.0).sin() / (pitch * PI() / 180.0).cos();
let rb = rp + 12.0 + boot_h * 0.15;
// the boot must reach down below the plate on the low side
let drop = rb * tn + 5.0;
let base = box_centered(plate, plate, t).translate([0, 0, -t / 2.0]).rotate_x(pitch);
let boot = cone(rb, rp + t, boot_h + drop).translate([0, 0, -drop]);
let above = box_centered(plate * 2.0, plate * 2.0, boot_h * 4.0).translate([0, 0, boot_h * 2.0 - t]).rotate_x(pitch);
let flashing = base + (boot & above);
flashing - cylinder([0, 0, -drop - 10.0], "Z", rp, boot_h + drop + 20.0)
