// Adhesive desk cable clip for three 5 mm cables: 40 x 12 x 2 mm base, three C-shaped cradles opening upward
let cable = 5.0; // [3.0, 8.0] Cable diameter (mm)
let n = 3; // [1, 6] Cables
let pitch = cable + 4.0;
let len = n.to_float() * pitch + 4.0;
let clip = box_from_corners([0, 0, 0], [len, 12.0, 2.0]).fillet(2.0, "|Z");
for k in 0..n {
    let x = 2.0 + pitch * (k.to_float() + 0.5);
    let ring = cylinder([x, 0, 2.0 + cable / 2.0], "Y", cable / 2.0 + 1.2, 12.0) - cylinder([x, -1, 2.0 + cable / 2.0], "Y", cable / 2.0, 14.0);
    clip += ring - box_centered(cable * 0.75, 14.0, cable).translate([x, 6.0, 2.0 + cable + 1.0]);
}
clip
