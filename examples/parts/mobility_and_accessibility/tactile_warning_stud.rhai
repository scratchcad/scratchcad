// Tactile warning stud: ISO 23599 truncated-dome stud for blister paving, 25 mm base diameter, 12 mm top, 5 mm raised height, 8 mm x 20 mm fixing spigot with 3 anchoring ribs
// # Dome
let base_d = 25.0; // [20.0, 35.0] Base diameter (mm)
let top_d = 12.0; // [8.0, 20.0] Top diameter (mm)
let height = 5.0; // [4.0, 6.0] Raised height (mm)
// # Spigot
let spigot_d = 8.0; // [6.0, 12.0] Spigot diameter (mm)
let spigot_length = 20.0; // [10.0, 30.0] Spigot length (mm)
let ribs = 3; // [1, 5] Number of anchoring ribs
let dome = sketch("XZ").move_to(0, 0).hline_to(base_d / 2.0).vline(0.8).line_to(top_d / 2.0 + 1.0, height - 0.3).line_to(top_d / 2.0, height).hline_to(0).close().to_face().revolve("Z", 360);
let spigot = cylinder([0, 0, -spigot_length], "Z", spigot_d / 2.0, spigot_length + 0.01);
let rs = [];
for i in 0..ribs {
    let z = -spigot_length + 3.0 + i.to_float() * (spigot_length - 6.0) / max(ribs - 1, 1).to_float();
    rs.push(cone(spigot_d / 2.0, spigot_d / 2.0 + 1.0, 2.0).translate([0, 0, z]));
}
let tip = cylinder([0, 0, -spigot_length - 0.01], "Z", spigot_d / 2.0 + 1.5, 1.0) - cone(spigot_d / 2.0 - 1.0, spigot_d / 2.0 + 0.5, 1.5).translate([0, 0, -spigot_length - 0.02]);
let raw = dome + spigot + fuse_all(rs);
raw - tip
