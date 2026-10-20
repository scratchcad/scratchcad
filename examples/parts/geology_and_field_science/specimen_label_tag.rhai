// Specimen tie-on label tag: 60 x 30 x 1.5 mm with 5 mm corner radii, a 4 mm string hole with a 7 mm reinforcing ring 2.5 mm thick, and a 44 x 18 mm writing panel recessed 0.4 mm
let length = 60.0; // [40.0, 90.0] Tag length (mm)
let width = 30.0; // [20.0, 45.0] Tag width (mm)
const t = 1.5;
let tag = box_from_corners([0, 0, 0], [length, width, t]);
let tag = tag.fillet(5.0, tag.edges("|Z"));
let ring = cylinder([6.0, width / 2.0, 0], "Z", 3.5, 2.5);
let panel = box_from_corners([12.0, 6.0, t - 0.4], [length - 4.0, width - 6.0, t + 1.0]);
tag + ring - panel - cylinder([6.0, width / 2.0, -1.0], "Z", 2.0, 5.0)
