// ESD wrist strap grounding clip: 4 mm banana socket body with a 10 mm snap stud, 15 x 30 mm body
let width = 15.0; // [10.0, 20.0] Body width (mm)
let length = 30.0; // [20.0, 40.0] Body length (mm)
let body = box_centered(width, 8.0, length).translate([0, 0, length / 2.0]);
let b = body.fillet(3.0, body.edges("|Y"));
let snap = cylinder([0, -7.0, length - 8.0], "Y", 2.0, 3.01) + sphere([0, -7.0, length - 8.0], 2.6);
b + snap - cylinder([0, 0, -1], "Z", 2.0, length - 12.0)
