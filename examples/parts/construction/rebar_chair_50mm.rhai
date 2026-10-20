// Rebar chair for 50 mm cover: four-legged plastic spacer 50 mm tall, saddle for 16 mm bar, 60 mm footprint ring
let cover = 50.0; // [20.0, 75.0] Concrete cover (mm)
let bar = 16.0; // [8.0, 32.0] Rebar diameter (mm)
let ring = cylinder(30.0, 3.0) - cylinder([0, 0, -1], "Z", 25.0, 5.0);
let legs = [];
for k in 0..4 { legs.push(polygon([[22.0, 0, 0], [28.0, 0, 0], [6.0, 0, cover], [2.0, 0, cover]]).to_face().extrude([0, 3.0, 0]).translate([0, -1.5, 0]).rotate_z(k.to_float() * 90.0)); }
let saddle = box_centered(20.0, 10.0, bar * 0.6).translate([0, 0, cover + bar * 0.3 - 2.0]) - cylinder([0, -6.0, cover + bar / 2.0], "Y", bar / 2.0, 12.0);
fuse_all([ring, saddle] + legs)
