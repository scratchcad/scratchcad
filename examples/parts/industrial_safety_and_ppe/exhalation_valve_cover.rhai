// Half-mask exhalation valve cover: 38 mm dome 14 mm tall, 1.5 mm wall, eight 3 x 8 mm vent slots, 32 mm snap ring with a 0.6 mm bead
let diameter = 38.0; // [30.0, 50.0] Cover diameter (mm)
let height = 14.0; // [10.0, 20.0] Cover height (mm)
let wall = 1.5; // [1.0, 2.5] Wall thickness (mm)
let vents = 8; // [4, 12] Number of vent slots
let r = diameter / 2.0;
let outer = polygon("XZ", [[0, 0], [r, 0], [r, 4.0], [r - 4.0, height - 2.0], [r * 0.5, height], [0, height]]).to_face().revolve([0, 0, 0], "Z", 360);
let inner = polygon("XZ", [[0, -1.0], [r - wall, -1.0], [r - wall, 4.0], [r - 4.0 - wall, height - 2.0 - wall], [r * 0.5, height - wall], [0, height - wall]]).to_face().revolve([0, 0, 0], "Z", 360);
let slots = [];
for k in 0..vents { slots.push(box_centered(8.0, 3.0, 12.0).translate([r - 3.5, 0, height - 4.0]).rotate_z(k.to_float() * 360.0 / vents.to_float())); }
let bead = cylinder([0, 0, 1.0], "Z", r - wall + 0.01, 1.0) - cylinder([0, 0, 0], "Z", r - wall - 0.6, 3.0);
outer - inner - compound(slots) + bead
