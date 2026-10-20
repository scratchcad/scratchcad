// Tubeless valve lockring knob: five-lobe star 26 mm over the lobes, 8 mm thick, 7 mm lobes, 6.2 mm bore with a 5 mm deep 8.2 mm counterbore for the rim seal side
let lobe_d = 26.0; // [20.0, 34.0] Diameter over lobes (mm)
let lobes = 5; // [3, 8] Number of lobes
let thickness = 8.0; // [5.0, 12.0] Knob thickness (mm)
let bore = 6.2; // [5.4, 8.0] Bore for the valve stem (mm)
const lobe_r = 3.5;
let rc = lobe_d / 2.0 - lobe_r;
let parts = [cylinder(rc, thickness)];
for i in 0..lobes {
    let a = i.to_float() * 360.0 / lobes.to_float() * PI() / 180.0;
    parts.push(cylinder([rc * cos(a), rc * sin(a), 0], "Z", lobe_r, thickness));
}
let knob = fuse_all(parts);
knob - fuse_all([
    cylinder([0, 0, -1.0], "Z", bore / 2.0, thickness + 2.0),
    cylinder([0, 0, -1.0], "Z", bore / 2.0 + 1.0, 6.0),
])
