// 10 ml oral dosing syringe, assembled: 14.5 mm bore barrel 61 mm long (10 ml), 30 mm finger flange, 4.5 mm oral tip, cross-rib plunger with stopper and thumb press
let bore = 14.5; // [8.0, 22.0] Barrel bore (mm)
let capacity = 10.0; // [1.0, 30.0] Capacity (ml)
let wall = 1.0; // [0.8, 2.0] Barrel wall (mm)
let tip_diameter = 4.5; // [3.0, 7.0] Oral tip diameter (mm)
let rb = bore / 2.0;
let L = capacity * 1000.0 / (PI() * rb * rb);
let ro = rb + wall;
let barrel = sketch("XZ").move_to(0, -10.0).hline_to(tip_diameter / 2.0).vline_to(-2.0).line_to(ro, 0).vline_to(L + 8.0).hline_to(0).close().to_face().revolve("Z", 360);
barrel -= cylinder([0, 0, 0], "Z", rb, L + 10.0);
barrel -= cylinder([0, 0, -11.0], "Z", 0.9, 12.0);
let flange = box_centered(2.0 * ro + 16.0, 2.0 * ro + 2.0, 2.0).translate([0, 0, L + 7.0]).fillet(ro, "|Z");
barrel = flange - cylinder([0, 0, L + 5.0], "Z", rb, 5.0) + barrel;
let marks = [];
for i in 1..=(capacity.to_int()) {
    let z = L * i.to_float() / capacity;
    marks.push(box_centered(if i % 5 == 0 { 6.0 } else { 3.0 }, 0.6, 0.4).translate([0, -ro, z]));
}
barrel = fuse_all([barrel] + marks);
// plunger at the empty position: stopper on the tip shoulder
let rs = rb - 0.08;
let stopper = sketch("XZ").move_to(0, 0.2).hline_to(rs - 0.6).line_to(rs, 1.0).vline_to(3.0).line_to(rs - 0.4, 3.6).vline_to(5.0).line_to(rs, 5.6).vline_to(7.0).hline_to(0).close().to_face().revolve("Z", 360);
let ribs = box_centered(2.0 * rb - 1.0, 1.4, L + 12.0).translate([0, 0, (L + 12.0) / 2.0 + 6.9]);
ribs = ribs + ribs.rotate_z(90.0);
let press = cylinder([0, 0, L + 18.8], "Z", rb + 2.0, 1.6);
let plunger = fuse_all([stopper, ribs, press]);
compound([barrel, plunger])
