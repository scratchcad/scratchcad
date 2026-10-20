// Free-flow liquor pourer: tapered 20 mm stem from 19 to 16 mm with three sealing fins for a 18.5 mm bottle neck, 24 mm collar, 6 mm spout tube bent 35 degrees, 4.5 mm bore and a 2 mm air tube
let stem_length = 20.0; // [12.0, 30.0] Stem length (mm)
let stem_diameter = 19.0; // [15.0, 24.0] Stem diameter at the collar (mm)
let spout_length = 35.0; // [20.0, 60.0] Spout length (mm)
let spout_angle = 35.0; // [0.0, 60.0] Spout bend angle (degrees)
let bore = 4.5; // [3.0, 6.0] Pour bore diameter (mm)
let rs = stem_diameter / 2.0;
let ro = bore / 2.0 + 0.75;
let stem = cone(rs - 1.5, rs - 0.7, stem_length).translate([0, 0, -stem_length]);
let parts = [stem, cylinder([0, 0, 0], "Z", rs + 2.5, 4.0).fillet(1.0, ">Z")];
for i in 0..3 {
    let z = -4.0 - i.to_float() * (stem_length - 8.0) / 2.0;
    let r = rs - 0.7 - (rs - 1.5 - (rs - 0.7)) * (-z / stem_length) ;
    parts.push(cone(r + 0.8, r - 0.2, 1.6).translate([0, 0, z - 0.8]));
}
// spout: straight riser then the bent tube
const zj = 12.0;
let dir = [(spout_angle * PI() / 180.0).sin(), 0, (spout_angle * PI() / 180.0).cos()];
parts.push(cylinder([0, 0, 3.9], "Z", ro, zj - 3.9));
parts.push(sphere([0, 0, zj], ro));
parts.push(cylinder([0, 0, zj], dir, ro, spout_length));
let pourer = fuse_all(parts);
// bores (they overlap each other, so fuse them first), and the air tube beside the spout
let bores = fuse_all([cylinder([0, 0, -stem_length - 1.0], "Z", bore / 2.0, stem_length + zj + 1.0), sphere([0, 0, zj], bore / 2.0), cylinder([0, 0, zj], dir, bore / 2.0, spout_length + 1.0)]);
pourer = pourer - bores;
let air = cylinder([-rs + 3.5, 0, -stem_length - 1.0], "Z", 1.0, stem_length + 5.5);
pourer + (cylinder([-rs + 3.5, 0, 3.9], "Z", 1.8, 4.0) - air) - air
