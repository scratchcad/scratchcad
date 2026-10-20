// Cabinet fan filter frame for a 120 mm fan: 148 x 148 x 3 mm front frame with 4 mm rounded corners, 120 x 120 mm opening crossed by 45 degree louvres (2 mm blades on 8 mm pitch), 12 mm deep 124 x 124 mm rear spigot with 2 mm walls for the 125 mm cutout
let frame = 148.0; // [140.0, 180.0] Frame size (mm)
let opening = 120.0; // [90.0, 130.0] Grille opening (mm)
let pitch = 8.0; // [6.0, 14.0] Louvre pitch (mm)
let spigot_depth = 12.0; // [6.0, 20.0] Spigot depth (mm)
const t = 3.0;
const wall = 2.0;
let spigot = opening + 4.0;
let front = box_centered(frame, frame, t).translate([0, 0, t / 2.0]);
let front = front.fillet(4.0, front.edges("|Z"));
let rear = box_centered(spigot, spigot, spigot_depth + 0.5).translate([0, 0, -spigot_depth / 2.0 + 0.25])
    - box_centered(spigot - 2.0 * wall, spigot - 2.0 * wall, spigot_depth + 2.0).translate([0, 0, -spigot_depth / 2.0]);
let body = front + rear - box_centered(opening, opening, t + 2.0).translate([0, 0, t / 2.0]);
let n = (opening / pitch).to_int();
let blades = [];
for i in 0..n {
    let y = -opening / 2.0 + pitch * (i.to_float() + 0.5);
    blades.push(box_centered(opening + 1.0, 2.0, 5.0).rotate_x(45.0).translate([0, y, t / 2.0]));
}
let grille = fuse_all(blades) & box_centered(opening + 0.5, opening - 0.1, t).translate([0, 0, t / 2.0]);
body + grille
