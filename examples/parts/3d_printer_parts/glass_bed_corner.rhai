// Corner bracket holding a glass bed: 20 x 20 mm L, 4 mm thick, 3.2 mm glass step, M3 hole
let size = 20.0; // [12.0, 35.0] Size (mm)
let thickness = 4.0; // [2.5, 6.0] Base thickness (mm)
let glass = 3.2; // [2.0, 5.0] Glass thickness (mm)
let lip = 1.5; // [1.0, 3.0] Lip thickness (mm)
let base = polygon([[0, 0], [size, 0], [size, size * 0.4], [size * 0.4, size], [0, size]]).to_face().extrude(thickness + glass + lip);
let pocket = box_from_corners([3.0, 3.0, thickness], [size + 1, size + 1, thickness + glass]);
(base - pocket) - cylinder([size * 0.6, size * 0.6, -1], "Z", 1.65, thickness + glass + lip + 2.0)
