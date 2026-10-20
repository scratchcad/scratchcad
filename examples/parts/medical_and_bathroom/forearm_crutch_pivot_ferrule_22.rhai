// Forearm crutch pivoting ferrule for 22 mm tubes: 28 mm sleeve 40 mm tall on a 16 mm ball joint, 50 mm flexible foot with radial tread
let tube_diameter = 22.0; // [16.0, 28.0] Crutch tube diameter (mm)
let sleeve_height = 40.0; // [25.0, 60.0] Sleeve height (mm)
let foot_diameter = 50.0; // [35.0, 70.0] Foot diameter (mm)
let ball_diameter = 16.0; // [10.0, 22.0] Ball diameter (mm)
let rt = tube_diameter / 2.0 + 0.2;
let rs = rt + 3.0;
let rf = foot_diameter / 2.0;
let rb = min(ball_diameter / 2.0, rs - 1.0);
const zb = 12.0;
// upper: sleeve with ball
let sleeve = sketch("XZ").move_to(0, zb + rb * 0.6).hline_to(rb * 0.8).line_to(rs, zb + rb + 6.0).vline_to(zb + rb + 6.0 + sleeve_height)
    .hline_to(0).close().to_face().revolve("Z", 360);
sleeve = sleeve + sphere([0, 0, zb], rb);
sleeve -= cylinder([0, 0, zb + rb + 8.0], "Z", rt, sleeve_height);
let ribs = [];
for i in 0..4 { ribs.push(torus(rs, 0.7).translate([0, 0, zb + rb + 12.0 + i.to_float() * 6.0])); }
sleeve = sleeve - compound(ribs);
// foot: socket around the ball, bellows skirt and tread
let foot = sketch("XZ").move_to(0, 0).hline_to(rf).vline_to(4.0).line_to(rb + 6.0, zb - 1.0).vline_to(zb + rb * 0.55).hline_to(0).close()
    .to_face().revolve("Z", 360);
foot -= sphere([0, 0, zb], rb + 0.3);
foot -= cylinder([0, 0, zb], "Z", rb * 0.85, rb + 2.0);
let treads = [];
for i in 0..24 {
    treads.push(box_from_corners([rf * 0.35, -0.8, -1.0], [rf + 1.0, 0.8, 1.0]).rotate_z(i.to_float() * 15.0));
}
foot -= compound(treads);
compound([sleeve, foot])
