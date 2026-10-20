// Film drying clip: 40 mm jaws 12 mm wide opening 6 degrees from a 6 mm hinge loop, with an 8 mm hook eye, sprung as a single 2 mm thick V body
let length = 40.0; // [30.0, 60.0] Clip length (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
const t = 2.0;
let a = box_from_corners([0, 0, 0], [length, width, t]).rotate_y(-6.0);
let b = box_from_corners([0, 0, -t], [length, width, 0]).rotate_y(6.0);
let hinge = cylinder([0, 0, 0], "Y", 3.0, width) - cylinder([0, -1.0, 0], "Y", 1.5, width + 2.0);
let hook = cylinder([-6.0, width / 2.0, 0], "Z", 4.0, t) - cylinder([-6.0, width / 2.0, -1.0], "Z", 2.5, t + 2.0);
a + b + hinge + hook
