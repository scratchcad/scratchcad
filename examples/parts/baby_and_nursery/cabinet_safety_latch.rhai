// Child-safety cabinet latch hook: 70 mm flexible arm 10 mm wide 2 mm, 8 mm barb, 25 x 15 mm screw base
let length = 70.0; // [50.0, 100.0] Arm length (mm)
let width = 10.0; // [8.0, 15.0] Arm width (mm)
let t = 2.0; // [1.5, 3.0] Arm thickness (mm)
let base = box_from_corners([-12.5, -7.5, 0], [12.5, 7.5, 4.0]);
let b = base.fillet(3.0, base.edges("|Z"));
let arm = box_from_corners([-width / 2.0, -t / 2.0, 3.99], [width / 2.0, t / 2.0, length]);
let barb = polygon([[0, t / 2.0 - 0.01, length - 12.0], [0, t / 2.0 + 4.0, length - 8.0], [0, t / 2.0 + 4.0, length - 6.0], [0, t / 2.0 - 0.01, length - 6.0]]).to_face().extrude([width, 0, 0]).translate([-width / 2.0, 0, 0]);
let push = box_from_corners([-width / 2.0, -t / 2.0, length - 0.01], [width / 2.0, t / 2.0 + 6.0, length + 2.0]);
b + arm + barb + push - cylinder([-8.0, 0, -1], "Z", 1.8, 6.0) - cylinder([8.0, 0, -1], "Z", 1.8, 6.0)
