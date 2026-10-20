// Pill crusher press lid for a 40 mm crusher cup: 49.6 mm cap plate 4 mm thick with a 2 mm locating skirt 6 mm deep clearing the cup's 2.5 mm wall, a 39 mm crushing plunger 8 mm deep with a 3 mm conical point and 8 radial ribs 1.2 mm high on its face, and a 28 mm palm knob 14 mm tall with a 2 mm chamfer
let cup_bore = 40.0; // [30.0, 55.0] Cup bore (mm)
let plunger_len = 8.0; // [4.0, 14.0] Plunger depth (mm)
let knob_d = 28.0; // [20.0, 40.0] Knob diameter (mm)
let knob_h = 14.0; // [8.0, 22.0] Knob height (mm)
let ribs = 8; // [4, 12] Number of crushing ribs
const plate_t = 4.0;
const rib_h = 1.2;
let rp = cup_bore / 2.0 - 0.5;
let rcap = cup_bore / 2.0 + 4.8;
let kr = min(knob_d / 2.0, rcap - 1.0);
let knob = cylinder([0, 0, plate_t - 0.5], "Z", kr, knob_h + 0.5);
let knob = knob.chamfer(2.0, knob.edges(">Z"));
let skirt = cylinder([0, 0, -6.0], "Z", rcap, 6.5) - cylinder([0, 0, -7.0], "Z", rcap - 2.0, 7.0);
let parts = [
    cylinder(rcap, plate_t),
    skirt,
    knob,
    cylinder([0, 0, -plunger_len], "Z", rp, plunger_len + 0.5),
    cone(0.5, rp * 0.5, 3.0).translate([0, 0, -plunger_len - 3.0]),
];
for i in 0..ribs {
    parts.push(box_from_corners([rp * 0.45, -0.8, -plunger_len - rib_h], [rp - 1.0, 0.8, -plunger_len + 0.5]).rotate_z((i + 0.5) * 360.0 / ribs));
}
fuse_all(parts)
