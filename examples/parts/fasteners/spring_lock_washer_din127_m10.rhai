// Split spring lock washer DIN 127 B M10: 10.2 mm inside, 18.1 mm outside diameter, 2.2 mm square section, split 2 mm wide and set 2.2 mm out of plane
let inner_diameter = 10.2; // [2.1, 31.5] Inside diameter (mm)
let outer_diameter = 18.1; // [4.4, 49.5] Outside diameter (mm)
let thickness = 2.2; // [0.5, 6.0] Section thickness (mm)
let set = 2.2; // [0.5, 6.0] Out-of-plane set at the split (mm)
const split = 2.0;
const steps = 24;
let ri = inner_diameter / 2.0;
let ro = max(outer_diameter / 2.0, ri + 1.0);
let gap = split / ((ri + ro) / 2.0) * 180.0 / PI();
let sections = [];
for i in 0..=steps {
    let u = i.to_float() / steps.to_float();
    let a = gap / 2.0 + u * (360.0 - gap);
    let z = u * set;
    let sq = polygon([[ri, 0, z], [ro, 0, z], [ro, 0, z + thickness], [ri, 0, z + thickness]]).rotate("Z", a);
    sections.push(sq);
}
loft(sections, true)
