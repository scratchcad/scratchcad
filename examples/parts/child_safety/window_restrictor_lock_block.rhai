// Window restrictor lock block: 40 x 20 x 15 mm housing for a 3 mm steel cable with 100 mm restrictor, a 4 mm cable bore with an 8 mm ferrule pocket, a 10 mm keyed lock bore and two 4 mm screw holes
let cable = 3.0; // [2.0, 5.0] Cable diameter (mm)
let ferrule = 8.0; // [6.0, 12.0] Ferrule diameter (mm)
let b = box_from_corners([0, 0, 0], [40.0, 20.0, 15.0]);
let b = b.fillet(3.0, b.edges("|Z"));
let cuts = [cylinder([-1.0, 10.0, 8.0], "X", cable / 2.0 + 0.5, 42.0), cylinder([5.0, 10.0, 8.0], "X", ferrule / 2.0, 12.0), cylinder([28.0, 10.0, -1.0], "Z", 5.0, 17.0), cylinder([10.0, 4.0, -1.0], "Z", 2.0, 17.0), cylinder([10.0, 16.0, -1.0], "Z", 2.0, 17.0)];
b - fuse_all(cuts)
