// 19 mm bevel-edge wood chisel: 130 mm blade 5 mm thick with a 25 deg bevel, 14 mm ferrule, 28 mm handle 110 mm long
let w = 19.0; // [6.0, 38.0] Blade width (mm)
let blade_len = 130.0; // [80.0, 200.0] Blade length (mm)
let blade = polygon([[0, 0, 0], [blade_len, 0, 0], [blade_len, 0, 5], [11, 0, 5]]).to_face().extrude([0, w, 0]).translate([0, -w / 2.0, 0]);
blade -= polygon([[0, -w / 2.0 - 0.01], [blade_len - 10.0, -w / 2.0 - 0.01], [0, -w / 2.0 + 1.5]]).to_face().extrude(6.0).translate([0, 0, 2.0]);
blade -= polygon([[0, w / 2.0 + 0.01], [0, w / 2.0 - 1.5], [blade_len - 10.0, w / 2.0 + 0.01]]).to_face().extrude(6.0).translate([0, 0, 2.0]);
let ferrule = cylinder([blade_len - 2.0, 0, 2.5], "X", 7.0, 22.0);
let handle = cylinder([blade_len + 18.0, 0, 2.5], "X", 14.0, 110.0).fillet(6.0, "%CIRCLE");
fuse_all([blade, ferrule, handle])
