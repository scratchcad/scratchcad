// Surfboard thruster fin: 110 mm base, 115 mm depth with swept-back rake, 7 mm thick root tapering to 2 mm, two 19 mm FCS-style tabs 8 mm tall
let base = 110.0; // [90.0, 120.0] Fin base length (mm)
let depth = 115.0; // [95.0, 125.0] Fin depth (mm)
const root_t = 7.0;
const tip_t = 2.0;
let outline = [[0, 0, 0], [base, 0, 0], [base * 0.88, 0, depth * 0.15], [base * 0.86, 0, depth * 0.4], [base * 0.92, 0, depth * 0.7], [base * 1.05, 0, depth], [base * 0.9, 0, depth * 0.97], [base * 0.65, 0, depth * 0.8], [base * 0.4, 0, depth * 0.55], [base * 0.15, 0, depth * 0.22]];
let blade = face(polygon(outline)).extrude([0, root_t, 0]).translate([0, -root_t / 2.0, 0]);
let taper_l = face(polygon([[-1.0, -root_t / 2.0 - 0.1, depth * 0.05], [-1.0, -root_t / 2.0 - 0.1, depth + 1.0], [-1.0, -tip_t / 2.0, depth + 1.0]])).extrude([base * 1.2, 0, 0]);
let taper_r = taper_l.mirror([0, 0, 0], [0, 1, 0]);
let fin = blade - taper_l - taper_r;
let tabs = box_from_corners([10.0, -2.5, -8.0], [29.0, 2.5, 0.01]) + box_from_corners([base - 35.0, -2.5, -8.0], [base - 16.0, 2.5, 0.01]);
fin + tabs - cylinder([base - 25.5, -5.0, -4.0], "Y", 1.5, 10.0)
