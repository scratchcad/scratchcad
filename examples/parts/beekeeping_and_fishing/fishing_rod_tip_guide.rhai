// Rod tip top guide: 2.0 mm tube 9 mm long, 4 mm ring frame with a 3 mm insert bore, 6 mm frame height
let tube_id = 2.0; // [1.2, 4.0] Blank tip diameter (mm)
let ring = 4.0; // [3.0, 8.0] Insert ring OD (mm)
let insert = 2.8; // [2.0, 6.0] Line bore (mm)
let tube = cylinder(tube_id / 2.0 + 0.4, 9.0) - cylinder([0, 0, -1], "Z", tube_id / 2.0, 9.0);
let frame = polygon([[0, -tube_id / 2.0 - 0.4, 8.0], [0, tube_id / 2.0 + 0.4, 8.0], [0, 0.6, 13.0], [0, -0.6, 13.0]]).to_face().extrude([0.8, 0, 0]).translate([-0.4, 0, 0]);
let r = cylinder([0, -0.5, 13.0 + ring / 2.0 - 0.3], "Y", ring / 2.0 + 0.6, 1.0) - cylinder([0, -1.0, 13.0 + ring / 2.0 - 0.3], "Y", insert / 2.0, 2.0);
tube + frame + r
