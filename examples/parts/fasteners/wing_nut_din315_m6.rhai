// Wing nut DIN 315 M6 (American form): 33 mm wing span, 16.5 mm tall, 12 mm conical hub 7.5 mm tall, 3 mm thick wings with rounded tips, 5 mm bore
let diameter = 6.0; // [4.0, 16.0] Thread size (mm)
let wing_span = 33.0; // [20.0, 80.0] Wing span (mm)
let height = 16.5; // [9.0, 40.0] Overall height (mm)
let hub_diameter = 12.0; // [7.0, 30.0] Hub diameter at the base (mm)
let hub_height = 7.5; // [4.0, 20.0] Hub height (mm)
let wing_thickness = 3.0; // [1.5, 6.0] Wing thickness (mm)
let rh = max(hub_diameter / 2.0, diameter / 2.0 + 2.0);
let hh = min(hub_height, height - 3.0);
let hub = cone(rh, rh * 0.8, hh);
let half = wing_span / 2.0;
let tip_r = (height - hh * 0.5) * 0.3;
let wing = sketch("XZ").move_to(rh * 0.5, 0.0).line_to(half - tip_r, hh * 0.4).arc_to(half, height - tip_r, half - tip_r * 1.2, height).line_to(rh * 0.5, hh).close();
let w = wing.to_face().extrude([0, wing_thickness, 0]).translate([0, -wing_thickness / 2.0, 0]);
let nut = fuse_all([hub, w, w.rotate("Z", 180.0)]);
nut = nut.fillet(min(0.6, wing_thickness * 0.2), "|Y");
nut - cylinder([0, 0, -1], "Z", diameter * 0.42, hh + 2.0) - cone(diameter / 2.0 + 0.2, diameter * 0.42, 0.6).translate([0, 0, -0.01])
