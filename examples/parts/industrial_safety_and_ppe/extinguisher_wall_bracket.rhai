// Fire extinguisher wall hook: 6 kg extinguisher bracket, 40 mm wide 4 mm plate 160 mm tall, 35 mm deep J-hook with 15 mm upturn for the valve neck, three 6 mm screw slots
let width = 40.0; // [30.0, 60.0] Bracket width (mm)
let height = 160.0; // [100.0, 220.0] Back plate height (mm)
let thickness = 4.0; // [3.0, 6.0] Plate thickness (mm)
let reach = 35.0; // [25.0, 60.0] Hook reach (mm)
let lift = 15.0; // [8.0, 25.0] Hook upturn (mm)
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thickness, height]);
let shelf = box_from_corners([-width / 2.0, 0.01 - reach, height - 30.0], [width / 2.0, 0.01, height - 30.0 + thickness]);
let lip = box_from_corners([-width / 2.0, -reach, height - 30.0], [width / 2.0, -reach + thickness, height - 30.0 + lift]);
let gusset = polygon("YZ", [[0.01, height - 30.0 - 25.0], [0.01, height - 30.0 + 0.01], [-reach * 0.6, height - 30.0 + 0.01]]).to_face().extrude([thickness, 0, 0]).translate([-thickness / 2.0, 0, 0]);
let body = back + shelf + lip + gusset;
let b = body.fillet(4.0, body.edges("|Y and <Z"));
let slots = [];
for z in [15.0, height / 2.0 - 20.0, height - 12.0] {
    let s = box_from_corners([-3.0, -1, z - 4.0], [3.0, thickness + 1.0, z + 4.0]);
    slots.push(s.fillet(2.9, s.edges("|Y")));
}
b - compound(slots)
