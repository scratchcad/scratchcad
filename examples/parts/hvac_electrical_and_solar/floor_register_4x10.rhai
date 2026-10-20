// Floor register for a 4 x 10 in duct: 298 x 146 mm face plate 3 mm thick with rounded corners, 18 louver slots, drop-in skirt 250 x 98 mm, 30 mm deep
let face_w = 298.0; // [200.0, 400.0] Face length (mm)
let face_d = 146.0; // [100.0, 200.0] Face width (mm)
let duct_w = 250.0; // [150.0, 350.0] Duct opening length (mm)
let duct_d = 98.0; // [70.0, 150.0] Duct opening width (mm)
let skirt = 30.0; // [10.0, 60.0] Skirt depth (mm)
let slots = 18; // [8, 30] Number of louver slots
const plate_t = 3.0;
const skirt_t = 1.2;
let dw = min(duct_w, face_w - 30.0);
let dd = min(duct_d, face_d - 30.0);
let plate = box_centered(face_w, face_d, plate_t).translate([0, 0, plate_t / 2.0]).fillet(6.0, "|Z").fillet(1.0, ">Z");
let sk = box_centered(dw, dd, skirt).translate([0, 0, -skirt / 2.0 + 0.5]) - box_centered(dw - 2.0 * skirt_t, dd - 2.0 * skirt_t, skirt + 2.0).translate([0, 0, -skirt / 2.0]);
let pitch = (dw - 16.0) / slots.to_float();
let cuts = [];
for i in 0..slots {
    let x = -dw / 2.0 + 8.0 + pitch * (i.to_float() + 0.5);
    cuts.push(box_centered(pitch * 0.55, dd - 12.0, 10.0).translate([x, 0, 0]));
}
plate + sk - compound(cuts)
