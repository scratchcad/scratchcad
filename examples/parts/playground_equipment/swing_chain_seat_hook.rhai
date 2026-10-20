// Swing seat chain hook: 6 mm round bar S-hook with 18 mm and 14 mm openings, about 58 mm overall, modelled as straight runs and half-ring bends in a flat plane
let bar = 6.0; // [4.0, 10.0] Bar diameter (mm)
let gap = 18.0; // [12.0, 25.0] Large opening (mm)
let r1 = gap / 2.0 + bar / 2.0;
let r2 = r1 * 0.8;
let ring1 = (cylinder([0, 0, -bar / 2.0], "Z", r1 + bar / 2.0, bar) - cylinder([0, 0, -bar], "Z", r1 - bar / 2.0, 2.0 * bar)) - box_from_corners([0, -r1 - bar, -bar], [r1 + bar, 0.0, bar]);
let ring2 = ((cylinder([0, 0, -bar / 2.0], "Z", r2 + bar / 2.0, bar) - cylinder([0, 0, -bar], "Z", r2 - bar / 2.0, 2.0 * bar)) - box_from_corners([-r2 - bar, 0, -bar], [0, r2 + bar, bar])).translate([r1 - r2, -30.0, 0]);
let shank = box_from_corners([r1 - bar / 2.0, -30.0, -bar / 2.0], [r1 + bar / 2.0, 0.01, bar / 2.0]);
ring1 + shank + ring2
