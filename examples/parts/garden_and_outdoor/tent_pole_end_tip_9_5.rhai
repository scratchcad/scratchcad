// Tent pole end tip for 9.5 mm aluminium poles: 7.9 mm shank 15 mm into the pole, 9.5 mm shoulder, 5 mm grommet pin 12 mm long, 2.4 mm shock-cord hole
let pole_diameter = 9.5; // [7.0, 13.0] Pole diameter (mm)
let pole_bore = 7.9; // [5.5, 11.0] Pole inside diameter (mm)
let shank_length = 15.0; // [8.0, 25.0] Shank length (mm)
let pin_diameter = 5.0; // [3.0, 8.0] Pin diameter (mm)
let pin_length = 12.0; // [6.0, 20.0] Pin length (mm)
let rb = min(pole_bore, pole_diameter - 0.8) / 2.0;
let ro = pole_diameter / 2.0;
let rp = min(pin_diameter / 2.0, ro - 0.5);
let tip = sketch("XZ").move_to(0, 0).hline_to(rb - 0.4).line_to(rb, 0.8).vline_to(shank_length).hline_to(ro).vline_to(shank_length + 3.0)
    .line_to(rp, shank_length + 4.5).vline_to(shank_length + 3.0 + pin_length - rp).arc_to(rp * 0.707, shank_length + 3.0 + pin_length - rp * 0.293, 0, shank_length + 3.0 + pin_length)
    .close().to_face().revolve("Z", 360);
let ribs = [];
for i in 0..3 {
    ribs.push(torus(rb, 0.25).translate([0, 0, 4.0 + i.to_float() * 3.5]));
}
let part = fuse_all([tip] + ribs);
part - cylinder([0, -ro, 3.0], "Y", 1.2, 2.0 * ro)
