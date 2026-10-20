// Stage spike mark puck: low-profile 40 mm glow marker disc 3 mm tall with a 1.5 mm chamfered edge, 30 mm luminous insert pocket 1.2 mm deep and a 5 mm arrow notch pointing downstage
let diameter = 40.0; // [25.0, 60.0] Puck diameter (mm)
let height = 3.0; // [2.0, 6.0] Puck height (mm)
let insert = 30.0; // [15.0, 45.0] Insert pocket diameter (mm)
let pocket = 1.2; // [0.6, 2.0] Pocket depth (mm)
let p = cylinder(diameter / 2.0, height);
let pk = p.chamfer(1.5, p.edges(">Z"));
let ins = cylinder([0, 0, height - pocket], "Z", insert.min(diameter - 8.0) / 2.0, pocket + 1.0);
let arrow = polygon("XY", [[-3.0, diameter / 2.0 - 7.0], [3.0, diameter / 2.0 - 7.0], [0, diameter / 2.0 + 1.0]]).to_face().extrude([0, 0, height + 2.0]).translate([0, 0, height - pocket]);
pk - ins - arrow
