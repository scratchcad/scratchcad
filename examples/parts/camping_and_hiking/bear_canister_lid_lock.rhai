// Bear canister lid lock tab: 30 x 15 x 6 mm quarter-turn latch tab with a coin slot 2 x 18 mm
let length = 30.0; // [20.0, 40.0] Tab length (mm)
let width = 15.0; // [10.0, 20.0] Tab width (mm)
let height = 6.0; // [4.0, 10.0] Height (mm)
let tab = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let t = tab.fillet(width / 2.0 - 0.01, tab.edges("|Z and <X"));
let ramp = polygon([[length - 10.0, 0], [length, 0], [length, height * 0.6]]).to_face().extrude(width + 2.0).rotate_x(90.0).translate([0, width / 2.0 + 1.0, -0.01]);
t - ramp - box_centered(18.0, 2.0, 4.0).rotate_z(90.0).translate([width / 2.0, 0, height]) - cylinder([width / 2.0, 0, -1], "Z", 2.2, height + 2.0)
