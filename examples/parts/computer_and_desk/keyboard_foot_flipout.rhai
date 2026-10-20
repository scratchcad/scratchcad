// Keyboard flip-out foot: 30 x 12 mm, 8 mm tall at the tip, 2.5 mm hinge pins, 1.5 mm wall
let length = 30.0; // [20.0, 45.0] Length (mm)
let width = 12.0; // [8.0, 20.0] Width (mm)
let tip = 8.0; // [5.0, 15.0] Tip height (mm)
let side = polygon([[0, 0], [length, 0], [length, tip], [0, 3.0]]).to_face().extrude([0, 0, width]).rotate_x(90.0).translate([0, width, 0]);
let hollow = polygon([[2.0, -1.0], [length - 1.5, -1.0], [length - 1.5, tip - 1.5], [2.0, 1.6]]).to_face().extrude([0, 0, width - 3.0]).rotate_x(90.0).translate([0, width - 1.5, 0]);
let pins = cylinder([1.5, -2.5, 1.5], "Y", 1.25, width + 5.0);
side - hollow + pins
