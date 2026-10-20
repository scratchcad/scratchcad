// Tusk tenon wedge: 90 mm long, 18 mm thick, tapers 22 to 12 mm (1:9 slope), 2 mm chamfers
let length = 90.0; // [50.0, 150.0] Length (mm)
let t = 18.0; // [10.0, 30.0] Thickness (mm)
let wide = 22.0; // [15.0, 40.0] Wide end (mm)
let narrow = 12.0; // [6.0, 25.0] Narrow end (mm)
let w = polygon([[0, 0], [wide, 0], [narrow, length], [0, length]]).to_face().extrude([0, 0, t]);
w.chamfer(1.5, w.edges("|Z"))
