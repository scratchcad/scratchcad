// 30/60 set square, 250 mm long leg, 3 mm thick, triangular cut-out, finger notch
let long_leg = 250.0; // [120.0, 350.0] Long leg (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
let border = 25.0; // [15.0, 40.0] Border width (mm)
let short_leg = long_leg * (30.0 * PI() / 180.0).tan();
let outer = polygon([[0, 0], [long_leg, 0], [0, short_leg]]).to_face().extrude([0, 0, thickness]);
let inner = polygon([[border, border], [long_leg - border * 3.73, border], [border, short_leg - border * 2.0]]).to_face().extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
outer - inner.fillet(4.0, inner.edges("|Z")) - cylinder([border + 10.0, border + 10.0, -1], "Z", 6.0, thickness + 2.0)
