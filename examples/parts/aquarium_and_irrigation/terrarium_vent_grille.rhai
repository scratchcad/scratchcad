// Terrarium vent grille: 100 mm round, 76 mm cut-out insert 8 mm deep, 2 mm slots on 4 mm pitch
let face_d = 100.0; // [70.0, 150.0] Face diameter (mm)
let insert_d = 76.0; // [50.0, 120.0] Insert diameter (mm)
let depth = 8.0; // [5.0, 15.0] Insert depth (mm)
let plate = cylinder(face_d / 2.0, 2.0) + cylinder([0, 0, -depth], "Z", insert_d / 2.0, depth + 0.01) - cylinder([0, 0, -depth - 1.0], "Z", insert_d / 2.0 - 2.0, depth + 1.0);
let slots = [];
let n = (insert_d / 4.0).floor().to_int();
for k in 0..n { slots.push(box_centered(2.0, insert_d, 6.0).translate([-insert_d / 2.0 + 2.0 + k.to_float() * 4.0, 0, 1.0])); }
plate - (compound(slots) & cylinder([0, 0, -1], "Z", insert_d / 2.0 - 4.0, 4.0))
