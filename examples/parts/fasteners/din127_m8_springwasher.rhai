// DIN 127 B M8 split spring lock washer: 8.1 mm ID, 14.8 mm OD, 2 x 2 mm section, ends offset by the thickness
let inner_d = 8.1; // [3.1, 24.5] Inner diameter (mm)
let section = 2.0; // [0.8, 6.0] Section width and thickness (mm)
let gap = 1.0; // [0.5, 3.0] Split gap (mm)
let r = inner_d / 2.0 + section / 2.0;
let sections = [];
let n = 24;
let sweep_deg = 360.0 - gap / r * 180.0 / PI();
for i in 0..=n {
    let t = i.to_float() / n.to_float();
    let a = t * sweep_deg;
    sections.push(rect(plane([r, 0, section / 2.0 + t * section], "Y", "X"), section, section).rotate_z(a));
}
loft(sections, true)
