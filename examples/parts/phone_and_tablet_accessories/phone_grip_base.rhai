// Collapsible phone grip base: 40 mm adhesive disc 2 mm thick, 25 mm twist-lock socket 4 mm tall with two 3 x 2 mm bayonet slots
let disc = 40.0; // [32.0, 50.0] Base diameter (mm)
let socket = 25.0; // [18.0, 30.0] Socket diameter (mm)
const t = 2.0;
let b = cylinder([0, 0, 0], "Z", disc / 2.0, t);
let b = b.fillet(0.8, b.edges(">Z"));
let ring = cylinder([0, 0, t - 0.01], "Z", socket / 2.0 + 1.5, 4.0) - cylinder([0, 0, t - 0.5], "Z", socket / 2.0, 5.0);
let slots = box_from_corners([-socket / 2.0 - 2.0, -1.5, t + 1.0], [socket / 2.0 + 2.0, 1.5, t + 3.0]);
let lip = (cylinder([0, 0, t + 3.0], "Z", socket / 2.0 + 0.01, 1.0) - cylinder([0, 0, t + 2.0], "Z", socket / 2.0 - 1.0, 3.0)) - box_from_corners([-socket, -4.0, 0], [socket, 4.0, 10.0]);
b + ring - slots + lip
