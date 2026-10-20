// Class 15 sewing machine bobbin: 20.3 mm flanges, 11.7 mm wide, 6 mm spindle bore, 4 flange holes
let flange_d = 20.3; // [18.0, 24.0] Flange diameter (mm)
let width = 11.7; // [9.0, 14.0] Overall width (mm)
let core_d = 9.0; // [7.0, 12.0] Core diameter (mm)
let bore = 6.0; // [4.0, 7.0] Spindle bore (mm)
let flange_t = 1.0; // [0.6, 2.0] Flange thickness (mm)
let spool = cylinder(flange_d / 2.0, flange_t) + cylinder([0, 0, flange_t - 0.01], "Z", core_d / 2.0, width - 2.0 * flange_t + 0.02) + cylinder([0, 0, width - flange_t], "Z", flange_d / 2.0, flange_t);
let holes = [];
let rh = (core_d + flange_d) / 4.0;
for k in 0..4 { holes.push(cylinder([rh, 0, -1], "Z", 1.6, width + 2.0).rotate_z(k.to_float() * 90.0)); }
spool - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0) - compound(holes)
