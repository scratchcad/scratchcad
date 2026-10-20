// Tree tie buckle with spacer: 30 mm figure-eight spacer block 25 mm long that keeps a 25 mm strap tie apart from the stake, two 27 x 4 mm strap slots and a 4 mm nail hole
let strap = 25.0; // [18.0, 40.0] Strap width (mm)
let gap = 25.0; // [15.0, 40.0] Tree-to-stake spacing (mm)
const h = 10.0;
let w = strap + 6.0;
let b = box_centered(gap + 16.0, w, h).translate([0, 0, h / 2.0]);
let b = b.fillet(3.0, b.edges("|Z"));
let slots = box_centered(4.0, strap + 2.0, h + 2.0).translate([-gap / 2.0 - 3.0, 0, h / 2.0]) + box_centered(4.0, strap + 2.0, h + 2.0).translate([gap / 2.0 + 3.0, 0, h / 2.0]);
let waist = cylinder([0, w / 2.0 + 5.0, -1.0], "Z", 8.0, h + 2.0) + cylinder([0, -w / 2.0 - 5.0, -1.0], "Z", 8.0, h + 2.0);
b - slots - waist - cylinder([0, 0, -1.0], "Z", 2.0, h + 2.0)
