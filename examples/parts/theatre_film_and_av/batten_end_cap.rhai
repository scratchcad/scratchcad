// Flying bar (batten) end cap: for 48.3 mm OD x 3.2 mm tube, 52 mm flat cap 8 mm with 1.5 mm chamfer, 41.5 mm push-in spigot 20 mm with four 0.8 mm grip fins, 5 mm hole for a safety bond
let tube_od = 48.3; // [33.7, 60.3] Tube outside diameter (mm)
let tube_wall = 3.2; // [2.0, 5.0] Tube wall (mm)
let spigot_length = 20.0; // [12.0, 30.0] Spigot length (mm)
let cap_height = 8.0; // [5.0, 12.0] Cap height (mm)
let id = tube_od - 2.0 * tube_wall;
let cap = polygon("XZ", [[0, 0], [tube_od / 2.0 + 2.0, 0], [tube_od / 2.0 + 2.0, cap_height - 1.5], [tube_od / 2.0 + 0.5, cap_height], [0, cap_height]]).to_face().revolve([0, 0, 0], "Z", 360);
let spigot = cylinder([0, 0, 0.01], "-Z", id / 2.0 - 0.6, spigot_length) - cylinder([0, 0, 1.0], "-Z", id / 2.0 - 3.0, spigot_length + 2.0);
let fins = [];
for i in 0..4 { fins.push(cylinder([0, 0, -4.0 - i.to_float() * (spigot_length - 6.0) / 4.0], "Z", id / 2.0 + 0.4, 1.0) - cylinder([0, 0, -30.0], "Z", id / 2.0 - 1.0, 60.0)); }
(cap + spigot + fuse_all(fins)) - cylinder([0, -tube_od, cap_height / 2.0], "Y", 2.5, tube_od * 2.0)
