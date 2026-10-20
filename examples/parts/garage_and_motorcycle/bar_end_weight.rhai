// Motorcycle bar end weight for 7/8 in (22 mm) bars: 30 mm head 38 mm long with a domed end, 14 mm insert spigot 25 mm with expander groove, M6 bolt bore with 10 mm counterbore
let head_d = 30.0; // [24.0, 40.0] Head diameter (mm)
let head_length = 38.0; // [20.0, 60.0] Head length (mm)
let spigot_d = 14.0; // [12.0, 18.0] Insert spigot diameter (mm)
let spigot_length = 25.0; // [15.0, 40.0] Spigot length (mm)
let grooves = 3; // [0, 5] Number of decorative grooves
const bolt_d = 6.5;
let r = head_d / 2.0;
let prof = sketch("XZ").move_to(0, 0).hline_to(r - 1.0).line_to(r, 1.0).vline_to(head_length - 8.0)
    .arc_to(r * 0.75, head_length - 1.8, r * 0.4, head_length).hline_to(0).close();
let head = prof.to_face().revolve("Z", 360);
let spigot = cylinder([0, 0, -spigot_length], "Z", spigot_d / 2.0, spigot_length + 0.5) - (cylinder([0, 0, -spigot_length + 6.0], "Z", spigot_d / 2.0 + 1.0, 4.0) - cylinder([0, 0, -spigot_length + 5.0], "Z", spigot_d / 2.0 - 1.5, 6.0));
let weight = head + spigot.chamfer(0.8, spigot.edges("<Z"));
for i in 0..grooves {
    weight = weight - (cylinder([0, 0, 8.0 + i.to_float() * 5.0], "Z", r + 1.0, 1.2) - cylinder([0, 0, 7.0 + i.to_float() * 5.0], "Z", r - 0.8, 3.0));
}
weight - cylinder([0, 0, -spigot_length - 1.0], "Z", bolt_d / 2.0, spigot_length + head_length + 2.0) - cylinder([0, 0, head_length - 7.0], "Z", 5.0, 8.0)
