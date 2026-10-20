// Mechanical pencil grip sleeve: 8 mm barrel, 35 mm long, 11 mm across flats rounded-triangle profile, 10 ribs
let barrel = 8.0; // [6.0, 10.0] Barrel diameter (mm)
let length = 35.0; // [25.0, 50.0] Length (mm)
let size = 11.0; // [9.0, 15.0] Grip size (mm)
let tri = polygon([[0, size], [-size * 0.866, -size * 0.5], [size * 0.866, -size * 0.5]]).to_face().extrude([0, 0, length]);
let t = tri.fillet(size * 0.3, tri.edges("|Z")) & cylinder([0, 0, -1], "Z", size * 0.75, length + 2.0);
let ribs = [];
for k in 0..10 { ribs.push(cylinder([0, 0, 4.0 + k.to_float() * 2.8], "Z", size, 0.8) - cylinder([0, 0, 3.0 + k.to_float() * 2.8], "Z", size * 0.5 - 0.3, 3.0)); }
t - compound(ribs) - cylinder([0, 0, -1], "Z", barrel / 2.0, length + 2.0)
