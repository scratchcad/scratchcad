// Dinghy hull drain bung: 33 mm head with a T-grip 25 x 8 mm, 25 mm threaded-style plug 15 mm with 4 grooves
let head = 33.0; // [25.0, 45.0] Head diameter (mm)
let plug = 25.0; // [18.0, 35.0] Plug diameter (mm)
let plug_l = 15.0; // [10.0, 25.0] Plug length (mm)
let h = cylinder(head / 2.0, 4.0);
let grip = box_centered(25.0, 8.0, 10.0).translate([0, 0, 8.99]);
let g = grip.fillet(3.9, grip.edges("|Y and >Z"));
let p = cylinder([0, 0, -plug_l], "Z", plug / 2.0, plug_l + 0.01);
let grooves = [];
for k in 0..4 { grooves.push(cylinder([0, 0, -plug_l + 2.0 + k.to_float() * 3.0], "Z", plug, 1.2) - cylinder([0, 0, -plug_l + 1.0 + k.to_float() * 3.0], "Z", plug / 2.0 - 1.0, 3.0)); }
h + g + p - compound(grooves)
