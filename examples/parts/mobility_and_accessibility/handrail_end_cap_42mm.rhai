// Handrail end cap: return-style cap for a 42.4 mm (1 1/4 in NB) handrail tube, push-fit spigot 25 mm long with 4 ribs for 2.6 mm wall tube, 45 mm rounded cap 12 mm deep with a tactile 3 mm end ring
// # Tube
let tube_od = 42.4; // [33.7, 48.3] Tube outside diameter (mm)
let tube_wall = 2.6; // [2.0, 4.0] Tube wall thickness (mm)
let spigot_length = 25.0; // [15.0, 40.0] Spigot length (mm)
// # Cap
let cap_d = 45.0; // [36.0, 52.0] Cap diameter (mm)
let cap_depth = 12.0; // [8.0, 20.0] Cap depth (mm)
let tube_id = tube_od - 2.0 * tube_wall;
let cap_r = max(cap_d / 2.0, tube_od / 2.0 + 0.5);
let cap = sketch("XZ").move_to(0, 0).hline_to(cap_r).vline(cap_depth * 0.4).line_to(cap_r - 2.0, cap_depth * 0.8).line_to(cap_r - 6.0, cap_depth).hline_to(0).close().to_face().revolve("Z", 360);
let ring = cylinder([0, 0, cap_depth - 0.01], "Z", cap_r - 8.0, 1.5) - cylinder([0, 0, cap_depth - 1.0], "Z", cap_r - 11.0, 3.0);
let spigot = cylinder([0, 0, -spigot_length], "Z", tube_id / 2.0 - 0.6, spigot_length + 0.01) - cylinder([0, 0, -spigot_length - 1.0], "Z", tube_id / 2.0 - 3.0, spigot_length);
let fins = [];
for i in 0..4 {
    let z = -spigot_length + 3.0 + i.to_float() * 5.0;
    fins.push(cone(tube_id / 2.0 - 0.6, tube_id / 2.0 + 0.4, 2.0).translate([0, 0, z]) - cylinder([0, 0, z - 1.0], "Z", tube_id / 2.0 - 3.0, 4.0));
}
cap + ring + spigot + fuse_all(fins)
