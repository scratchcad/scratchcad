// Linear ball bushing LM10UU: 10 mm bore, 19 mm OD, 29 mm long, two retaining ring grooves 1.3 mm wide to 18 mm diameter, 22 mm apart
let bore = 10.0; // [3.0, 40.0] Shaft diameter (mm)
let outer_diameter = 19.0; // [7.0, 60.0] Outer diameter (mm)
let length = 29.0; // [10.0, 80.0] Length (mm)
let groove_spacing = 22.0; // [5.0, 60.0] Distance between ring grooves (mm)
const groove_width = 1.3;
const groove_depth = 0.5;
let ri = bore / 2.0;
let ro = max(outer_diameter / 2.0, ri + 2.5);
let gs = min(groove_spacing, length - 2.0 * groove_width - 2.0);
let shell = cylinder(ro, length) - cylinder([0, 0, -1], "Z", ri, length + 2.0);
shell = shell.chamfer(0.4, "%CIRCLE");
let rings = [];
for s in [-1.0, 1.0] {
    let zc = length / 2.0 + s * gs / 2.0;
    rings.push(cylinder([0, 0, zc - groove_width / 2.0], "Z", ro + 1.0, groove_width) - cylinder([0, 0, zc - groove_width / 2.0 - 1.0], "Z", ro - groove_depth, groove_width + 2.0));
}
let seals = [];
for z in [-1.0, length - 0.6] { seals.push(cylinder([0, 0, z], "Z", ri + 1.2, 1.6)); }
shell - compound(rings) - compound(seals)
