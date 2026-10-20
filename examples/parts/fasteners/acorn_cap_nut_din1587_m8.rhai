// Domed acorn cap nut DIN 1587 M8: 13 mm across flats, 15 mm overall height, 6.5 mm hex with chamfer, 13 mm domed cap, blind 6.65 mm bore 11 mm deep
let thread_diameter = 8.0; // [4.0, 17.6] Thread size (mm)
let across_flats = 13.0; // [7.0, 26.8] Across flats (mm)
let height = 15.0; // [8.0, 45.0] Overall height (mm)
let hex_height = 6.5; // [3.0, 20.0] Hex height (mm)
let s = max(across_flats, thread_diameter * 1.4);
let hh = min(hex_height, height * 0.6);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, 0], [rw, 0, 0], [rc + 0.2, 0, dz], [rc + 0.2, 0, hh + 1.0], [0, 0, hh + 1.0]]).to_face().revolve("Z", 360);
let hex = polygon(hp).to_face().extrude(hh) & crown;
let rd = s * 0.48;
let dome_h = height - hh;
let dome = sketch("XZ").move_to(0.0, hh - 0.01).hline_to(rd).vline_to(height - rd).arc_to(rd * 0.7071, height - rd + rd * 0.7071, 0.0, height).close().to_face().revolve("Z", 360);
let nut = hex + dome;
let rm = thread_diameter * 0.83 / 2.0;
let depth = min(height - 2.5, hh + dome_h * 0.6);
nut - cylinder([0, 0, -1], "Z", rm, depth + 1.0) - cone(rm, 0.0, rm * 0.6).translate([0, 0, depth - 0.01]) - cone(thread_diameter / 2.0 + 0.3, rm - 0.01, 0.8).translate([0, 0, -0.01])
