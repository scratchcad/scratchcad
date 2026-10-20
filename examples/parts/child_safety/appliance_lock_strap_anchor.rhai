// Appliance safety strap anchor: 30 x 25 mm adhesive pad 2 mm with a 12 x 6 mm strap loop 8 mm tall for a 10 mm webbing strap
let strap = 10.0; // [6.0, 20.0] Strap width (mm)
let pad_l = 30.0; // [20.0, 45.0] Pad length (mm)
const t = 2.0;
let pad = box_centered(pad_l, 25.0, t).translate([0, 0, t / 2.0]);
let pad = pad.fillet(4.0, pad.edges("|Z"));
let loop_ = box_centered(strap + 4.0, 8.0, 8.0).translate([0, 0, t + 4.0 - 0.01]) - box_centered(strap + 0.5, 10.0, 4.0).translate([0, 0, t + 2.0 + 0.5]);
pad + loop_
