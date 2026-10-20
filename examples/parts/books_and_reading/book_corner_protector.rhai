// Book corner protector: 25 mm legs for a 30 mm thick book, 1 mm walls, triangular pocket
let leg = 25.0; // [15.0, 40.0] Leg length (mm)
let book = 30.0; // [10.0, 60.0] Book thickness (mm)
let t = 1.0; // [0.8, 2.0] Wall (mm)
let outer = polygon([[0, 0], [leg + t, 0], [0, leg + t]]).to_face().extrude([0, 0, book + 2.0 * t]).translate([-t, -t, -t]);
let inner = polygon([[0, 0], [leg + 5.0, 0], [0, leg + 5.0]]).to_face().extrude([0, 0, book]);
outer - inner
