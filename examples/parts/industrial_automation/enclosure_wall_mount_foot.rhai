// Enclosure wall-mount foot: 50 x 20 x 3 mm steel-style lug with a 6.5 mm keyhole, 2 mm offset step, 4.5 mm screw hole
let length = 50.0; // [35.0, 70.0] Lug length (mm)
let width = 20.0; // [15.0, 30.0] Lug width (mm)
let t = 3.0; // [2.0, 4.0] Thickness (mm)
let a = box_from_corners([0, 0, 0], [20.0, width, t]);
let step = box_from_corners([19.99 - t, 0, 0], [20.0, width, t + 2.0]);
let b = box_from_corners([19.99 - t, 0, 2.0], [length, width, t + 2.0]);
let bb = b.fillet(width / 2.0 - 0.5, b.edges("|Z and >X"));
a + step + bb - cylinder([8.0, width / 2.0, -1], "Z", 2.25, t + 2.0) - cylinder([length - 12.0, width / 2.0, 0], "Z", 3.25, t + 4.0) - box_from_corners([length - 12.0, width / 2.0 - 1.75, 0], [length - 4.0, width / 2.0 + 1.75, t + 4.0])
