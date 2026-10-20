// Clevis pin with head ISO 2341 form B, 10 x 40: 16 mm head 3 mm tall, 3.2 mm split-pin hole 5 mm from the end, 1 mm chamfers
let pin_diameter = 10.0; // [3.0, 30.0] Pin diameter (mm)
let pin_length = 40.0; // [10.0, 120.0] Length under head (mm)
let head_diameter = 16.0; // [5.0, 44.0] Head diameter (mm)
let head_height = 3.0; // [1.0, 8.0] Head height (mm)
let cross_hole = 3.2; // [0.8, 8.0] Split pin hole diameter (mm)
let hole_from_end = 5.0; // [2.0, 12.0] Split pin hole from the end (mm)
let rp = pin_diameter / 2.0;
let rh = max(head_diameter / 2.0, rp + 1.0);
let pin = cylinder([0, 0, -0.01], "Z", rp, pin_length + 0.01) + cylinder([0, 0, -head_height], "Z", rh, head_height);
pin = pin.chamfer(min(1.0, rp * 0.15), ">Z").chamfer(min(0.6, head_height * 0.25), "<Z");
let hd = min(cross_hole, pin_diameter * 0.45);
pin - cylinder([-rp - 1.0, 0, pin_length - hole_from_end], "X", hd / 2.0, pin_diameter + 2.0)
