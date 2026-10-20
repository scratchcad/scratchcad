// Nominal 1 kg dive belt weight: lead-sized block 75 x 40 x 30 mm (about 75 cm3 after the slot and fillets, so about 0.85 kg in lead) with a 52 x 6 mm belt slot through the long side and 3 mm radiused edges
let belt = 52.0; // [40.0, 55.0] Belt width slot (mm)
let length = 75.0; // [60.0, 100.0] Weight length (mm)
const w = 40.0;
const h = 30.0;
let b = box_centered(length, w, h).translate([0, 0, h / 2.0]);
let b = b.fillet(3.0, b.edges());
b - box_centered(belt + 1.0, w + 2.0, 6.5).translate([0, 0, h / 2.0])
