// Speed jump rope handle: 150 mm long, 26 mm grip tapering to a 20 mm neck, domed end, 5 mm rope bore, 10 x 4 mm bearing pocket at the top, 8 grip grooves
let length = 150.0; // [110.0, 200.0] Handle length (mm)
let grip_d = 26.0; // [20.0, 34.0] Grip diameter (mm)
let neck_d = 20.0; // [14.0, 26.0] Neck diameter (mm)
let rope_bore = 5.0; // [3.0, 8.0] Rope bore (mm)
let grooves = 8; // [0, 16] Number of grip grooves
const bearing_d = 10.0;
const bearing_h = 4.0;
let rg = grip_d / 2.0;
let rn = min(neck_d, grip_d) / 2.0;
let prof = sketch("XZ").move_to(0, 0).hline_to(rg * 0.6).arc_to(rg * (0.6 + 0.4 * 0.7071), rg * 0.4 * (1.0 - 0.7071), rg, rg * 0.4).line_to(rg, length * 0.75).line_to(rn, length - 6.0)
    .line_to(rn - 2.0, length).hline_to(0).close();
let handle = prof.to_face().revolve("Z", 360);
let cuts = [];
let pitch = (length * 0.6) / max(grooves, 1).to_float();
for i in 0..grooves {
    let z = length * 0.12 + i.to_float() * pitch;
    cuts.push(cylinder([0, 0, z], "Z", rg + 1.0, 1.5) - cylinder([0, 0, z - 1.0], "Z", rg - 0.8, 3.5));
}
if grooves > 0 { handle = handle - compound(cuts); }
handle - cylinder([0, 0, -1.0], "Z", rope_bore / 2.0, length + 2.0) - cylinder([0, 0, length - bearing_h], "Z", bearing_d / 2.0, bearing_h + 1.0)
