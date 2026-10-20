// Heart locket half (front), 20 mm wide x 19 mm tall plus the loop: domed face 4 mm high, hollowed from the back to leave walls about 0.8 mm, with a 3.6 mm bail loop on top
let width = 20.0; // [12.0, 35.0] Heart width (mm)
let depth = 4.0; // [2.5, 7.0] Dome height (mm)
let hollow = 0.85; // [0.7, 0.92] Hollow scale (fraction)
let loop_diameter = 3.6; // [2.5, 6.0] Bail loop diameter (mm)
let s = width / 20.0;
// heart from two lobes and a tapered point, in units of a 20 mm wide heart
let heart = fuse_all([
    cylinder([-4.8 * s, 2.0 * s, 0], "Z", 5.2 * s, depth + 1.0),
    cylinder([4.8 * s, 2.0 * s, 0], "Z", 5.2 * s, depth + 1.0),
    polygon([[0, -12.0 * s, 0], [-9.6 * s, -0.2 * s, 0], [0, 3.0 * s, 0], [9.6 * s, -0.2 * s, 0]]).to_face().extrude([0, 0, depth + 1.0]),
]);
// dome through a 0.6 mm edge at the farthest point of the outline (the tip, 11.5 mm from the dome centre)
let rim = 11.5 * s;
let dome_r = (rim * rim + (depth - 0.6) * (depth - 0.6)) / (2.0 * (depth - 0.6));
let domed = heart & sphere([0, -1.0 * s, depth - dome_r], dome_r);
let cavity = domed.scale([0, -1.0 * s, -0.6], hollow);
let locket = domed - cavity;
let rl = loop_diameter / 2.0;
let yl = 4.0 * s + rl - 0.6;
let lp = cylinder([0, yl, 0], "Z", rl, 1.2) - cylinder([0, yl, -1], "Z", rl * 0.5, 3.2);
locket + lp
