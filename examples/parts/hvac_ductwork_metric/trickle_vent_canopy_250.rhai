// External trickle vent canopy hood 250 mm: 250 x 22 mm hood 34 mm tall with 1.5 mm walls, open back over the window frame slot, 12 insect slots 3 x 12 mm in the underside, end fixing tabs with 3.5 mm screw holes
let length = 250.0; // [150.0, 400.0] Hood length (mm)
let projection = 22.0; // [15.0, 35.0] Projection from the frame (mm)
let height = 34.0; // [25.0, 50.0] Hood height (mm)
let slot_count = 12; // [6, 24] Number of underside slots
const wall = 1.5;
const tab = 12.0;
let hood = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, projection, height]);
hood = hood.fillet(projection * 0.6, hood.edges("|X and >Y and >Z"));
let cavity = box_from_corners([-length / 2.0 + wall, -1.0, wall], [length / 2.0 - wall, projection - wall, height - wall]);
cavity = cavity.fillet(projection * 0.6 - wall, cavity.edges("|X and >Y and >Z"));
hood = hood - cavity;
let tabs = box_from_corners([-length / 2.0 - tab, 0, height * 0.3], [length / 2.0 + tab, wall, height * 0.7]);
let pitch = (length - 20.0) / slot_count.to_float();
let slots = [];
for i in 0..slot_count {
    let x = -length / 2.0 + 10.0 + pitch * (i.to_float() + 0.5);
    slots.push(box_centered(min(3.0, pitch - 1.5), projection * 0.55, wall * 4.0).translate([x, projection * 0.45, 0]));
}
let holes = compound([cylinder([-length / 2.0 - tab / 2.0, -1, height / 2.0], "Y", 1.75, wall + 2.0), cylinder([length / 2.0 + tab / 2.0, -1, height / 2.0], "Y", 1.75, wall + 2.0)]);
hood + tabs - compound(slots) - holes
