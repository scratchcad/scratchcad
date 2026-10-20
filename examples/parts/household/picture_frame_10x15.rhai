// Picture frame for a 100 x 150 mm photo: 20 mm moulding, 12 mm deep, 6 mm rebate 5 mm deep, kickstand slot
let photo_w = 100.0; // [50.0, 300.0] Photo width (mm)
let photo_h = 150.0; // [50.0, 400.0] Photo height (mm)
let moulding = 20.0; // [10.0, 50.0] Moulding width (mm)
let depth = 12.0; // [6.0, 30.0] Depth (mm)
let rebate = 6.0; // [3.0, 10.0] Rebate width (mm)
let ow = photo_w + 2.0 * (moulding - rebate); let oh = photo_h + 2.0 * (moulding - rebate);
let frame = box_centered(ow, oh, depth).translate([0, 0, depth / 2.0]);
frame = frame - box_centered(photo_w - 2.0 * rebate + 0.0, photo_h - 2.0 * rebate, depth * 3.0);
frame = frame - box_centered(photo_w + 1.0, photo_h + 1.0, 5.0).translate([0, 0, 2.5 - 0.01]);
frame.fillet(3.0, ">Z and not (%LINE and >Z[1])").chamfer(1.0, "<Z and (>X or <X or >Y or <Y)")
