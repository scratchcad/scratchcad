// Non-polarizing 50:50 beamsplitter cube, Thorlabs BS013 class: 25.4 mm cube of two cemented N-BK7 right-angle prisms, 0.25 mm bevels
let size = 25.4; // [5.0, 50.8] Cube edge (mm)
let bevel = 0.25; // [0.1, 1.0] Edge bevel (mm)
let cement = 0.02; // [0.01, 0.1] Cement layer thickness (mm)
let a = polygon([[0, 0], [size, 0], [0, size]]).to_face().extrude(size).chamfer(bevel);
let b = polygon([[size, 0], [size, size], [0, size]]).to_face().extrude(size).chamfer(bevel);
let shift = cement / sqrt(2.0);
compound([a, b.translate([shift, shift, 0])]).translate([-size / 2.0, -size / 2.0, 0])
