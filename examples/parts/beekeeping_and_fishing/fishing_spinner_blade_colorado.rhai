// Colorado spinner blade #3: 27 x 18 mm cupped 0.5 mm blade with a 1.2 mm clevis hole
let length = 27.0; // [22.0, 45.0] Blade length (mm)
let width = 18.0; // [14.0, 30.0] Blade width (mm)
let t = 0.5; // [0.3, 1.0] Thickness (mm)
let cup = 3.0; // [1.0, 6.0] Cup depth (mm)
let rs = (width * width / 4.0 + cup * cup) / (2.0 * cup);
let shell = (sphere([0, 0, rs], rs) - sphere([0, 0, rs], rs - t)) & box_from_corners([-length, -length, -0.01], [length, length, cup]);
let outline = polygon([[0, -length / 2.0], [width / 2.0, -length * 0.1], [width * 0.35, length * 0.3], [0, length / 2.0], [-width * 0.35, length * 0.3], [-width / 2.0, -length * 0.1]]).to_face().extrude([0, 0, cup * 3.0]).translate([0, 0, -cup]);
let o = outline.fillet(width * 0.3, outline.edges("|Z"));
(shell & o) - cylinder([0, length / 2.0 - 2.5, -cup], "Z", 0.6, cup * 3.0)
