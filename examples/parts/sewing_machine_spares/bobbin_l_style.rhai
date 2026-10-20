// L-style aluminium bobbin: 20.3 mm flanges 0.8 mm thick, 8.9 mm wide, 7.5 mm core, 5.6 mm spindle bore, five 2.8 mm lightening holes in each flange on a 14 mm circle
let flange_d = 20.3; // [18.0, 24.0] Flange diameter (mm)
let width = 8.9; // [7.0, 11.0] Overall width (mm)
let core_d = 7.5; // [7.0, 9.0] Core diameter (mm)
let bore = 5.6; // [5.0, 6.0] Spindle bore (mm)
let holes = 5; // [3, 6] Holes per flange
const flange_t = 0.8;
const hole_d = 2.8;
let bobbin = fuse_all([
    cylinder(flange_d / 2.0, flange_t),
    cylinder([0, 0, flange_t - 0.2], "Z", core_d / 2.0, width - 2.0 * flange_t + 0.4),
    cylinder([0, 0, width - flange_t], "Z", flange_d / 2.0, flange_t),
]);
let rh = max(14.0 / 2.0, core_d / 2.0 + hole_d / 2.0 + 0.6);
let cuts = [cylinder([0, 0, -1.0], "Z", bore / 2.0, width + 2.0)];
for i in 0..holes {
    let a = i.to_float() * 360.0 / holes.to_float() * PI() / 180.0;
    cuts.push(cylinder([rh * cos(a), rh * sin(a), -1.0], "Z", hole_d / 2.0, width + 2.0));
}
bobbin - fuse_all(cuts)
