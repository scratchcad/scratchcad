// Built-up utensil handle for weak grip: 32 mm foam-style handle 110 mm long with 12 lengthwise flutes, 8 mm bore for a cutlery shank, domed end
let diameter = 32.0; // [22.0, 45.0] Handle diameter (mm)
let length = 110.0; // [70.0, 150.0] Handle length (mm)
let bore = 8.0; // [4.0, 14.0] Bore for the utensil shank (mm)
let flutes = 12; // [0, 24] Number of flutes
let R = diameter / 2.0;
let handle = cylinder(R, length - R * 0.5) + sphere([0, 0, length - R * 0.5], R) & cylinder(R + 1.0, length);
handle = handle.fillet(3.0, "<Z");
let cuts = [];
for i in 0..flutes {
    cuts.push(cylinder([R + 0.8, 0, 8.0], "Z", 2.0, length - R - 10.0).rotate_z(i.to_float() * 360.0 / flutes.to_float()));
}
if flutes > 0 { handle = handle - compound(cuts); }
handle - cylinder([0, 0, -1.0], "Z", min(bore / 2.0, R - 4.0), length * 0.8)
