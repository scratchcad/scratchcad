// 150 mm glass desiccator: bowl with a ground flange and a ledge for the plate, perforated porcelain plate, domed lid with knob
let d = 150.0; // [100.0, 300.0] Inner diameter (mm)
let r = d / 2.0;
let bowl = cylinder(r + 4.0, 130.0) + cylinder([0, 0, 122.0], "Z", r + 15.0, 8.0) - cylinder([0, 0, 8.0], "Z", r, 130.0) - cone(r * 0.4, r - 1.0, 60.0).translate([0, 0, 8.0 - 0.01]);
bowl += cylinder([0, 0, 68.0], "Z", r, 4.0) - cylinder([0, 0, 67.0], "Z", r - 6.0, 6.0);
let plate = cylinder([0, 0, 72.0], "Z", r - 0.5, 5.0);
for k in 0..12 { plate -= cylinder([r * 0.6, 0, 70.0], "Z", 4.0, 10.0).rotate("Z", k.to_float() * 30.0); }
plate -= cylinder([0, 0, 70.0], "Z", 4.0, 10.0);
let lid = (sphere([0, 0, 50.0], r + 15.0) - sphere([0, 0, 50.0], r + 11.0)) & box_centered(3.0 * r, 3.0 * r, 2.0 * r).translate([0, 0, 130.0 + r]);
lid = lid + cylinder([0, 0, 130.0], "Z", r + 15.0, 6.0) - cylinder([0, 0, 129.0], "Z", r + 4.0, 8.0) + cylinder([0, 0, 50.0 + r + 13.0], "Z", 12.0, 15.0) + sphere([0, 0, 50.0 + r + 30.0], 14.0);
compound([bowl, plate, lid.translate([0, 0, 2.0])])
