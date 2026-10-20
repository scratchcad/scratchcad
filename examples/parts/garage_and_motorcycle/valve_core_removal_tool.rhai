// Tyre valve core removal tool: 10 mm fluted body 60 mm long, forked tip with a 2.4 mm slot to turn Schrader cores, 5.4 mm bore at the tip, 7.0 mm cap-thread socket at the other end
let body_d = 10.0; // [9.0, 14.0] Body diameter (mm)
let length = 60.0; // [40.0, 90.0] Length (mm)
let slot_w = 2.4; // [1.6, 3.0] Fork slot width (mm)
let tip_d = 5.4; // [4.5, 6.0] Tip diameter (mm)
let flutes = 12; // [0, 24] Number of grip flutes
const tip_len = 6.0;
let r = body_d / 2.0;
let prof = sketch("XZ").move_to(0, 0).hline_to(tip_d / 2.0).vline_to(tip_len).line_to(r, tip_len + 6.0).vline_to(length - 1.0).line_to(r - 0.5, length).hline_to(0).close();
let tool = prof.to_face().revolve("Z", 360);
tool = tool - box_centered(slot_w, tip_d + 2.0, 8.0).translate([0, 0, 0]) - cylinder([0, 0, -1.0], "Z", 1.0, tip_len + 1.0);
tool = tool - cylinder([0, 0, length - 8.0], "Z", 3.5, 9.0);
let cuts = [];
for i in 0..flutes {
    cuts.push(cylinder([r + 0.25, 0, tip_len + 12.0], "Z", 0.7, length - tip_len - 20.0).rotate_z(i.to_float() * 360.0 / flutes.to_float()));
}
if flutes > 0 { tool = tool - compound(cuts); }
tool
