// Concealed (cup) hinge boring jig: 80 x 44 x 12 mm plate, 35.2 mm guide hole centred 22.5 mm from the door edge, 2 x 3 mm pilot holes on a 45 mm / 9.5 mm pattern, 8 mm edge fence 15 mm deep
let cup_d = 35.2; // [30.0, 36.0] Cup guide hole (mm)
let edge_offset = 22.5; // [19.0, 26.0] Cup centre from the door edge (mm)
let pattern = 45.0; // [40.0, 52.0] Pilot hole spacing (mm)
let pilot_offset = 9.5; // [8.0, 12.0] Pilot holes behind the cup centre (mm)
let t = 12.0; // [8.0, 20.0] Plate thickness (mm)
let w = max(80.0, pattern + 20.0);
let d = edge_offset + pilot_offset + 12.0;
let plate = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, d, t]);
let p = plate.fillet(5.0, plate.edges("|Z and >Y"));
let fence = box_from_corners([-w / 2.0, -8.0, -15.0], [w / 2.0, 0.01, t]);
let holes = [cylinder([0, edge_offset, -1], "Z", cup_d / 2.0, t + 2.0)];
for s in [-0.5, 0.5] { holes.push(cylinder([s * pattern, edge_offset + pilot_offset, -1], "Z", 1.5, t + 2.0)); }
let mark = polygon([[-1.5, -8.01, -16.0], [1.5, -8.01, -16.0], [0, -5.5, -16.0]]).to_face().extrude([0, 0, t + 17.0]);
p + fence - compound(holes) - mark
