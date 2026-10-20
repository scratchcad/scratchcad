// Safety breakaway lanyard connector: two-part barrel 30 x 12 mm, this is the female half 16 mm long with a 6 mm socket for the ball stud, 4 relief slots and a 3 mm cord eye
let length = 16.0; // [12.0, 24.0] Barrel length (mm)
let diameter = 12.0; // [9.0, 16.0] Barrel diameter (mm)
let socket = 6.0; // [4.0, 8.0] Ball socket diameter (mm)
let slots = 4; // [2, 6] Number of relief slots
let barrel = cylinder(diameter / 2.0, length);
let b = barrel.chamfer(0.8, barrel.edges(">Z"));
// socket: 6 mm ball seat with a 0.6 mm narrower mouth
let seat = sphere([0, 0, length - socket / 2.0 - 1.0], socket / 2.0) + cylinder([0, 0, length - socket / 2.0 - 1.0], "Z", socket / 2.0 - 0.3, socket);
let cuts = [];
for k in 0..slots { cuts.push(box_centered(1.0, diameter + 2.0, socket + 1.0).translate([0, 0, length - (socket + 1.0) / 2.0 + 0.5]).rotate_z(k.to_float() * 180.0 / slots.to_float())); }
let eye = cylinder([0, -1.5, -5.0], "Y", 4.0, 3.0) - cylinder([0, -2.0, -5.0], "Y", 1.5, 4.0);
let neck = box_from_corners([-2.0, -1.5, -5.0], [2.0, 1.5, 0.01]);
b - seat - fuse_all(cuts) + neck + eye
