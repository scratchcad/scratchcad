// Tablet wall mount pair half: 40 mm wide L-shelf for a 7.5 mm tablet with a 10 mm front lip, 3 mm walls, 50 mm backplate with two 4 mm countersunk holes
let tablet = 7.5; // [6.0, 14.0] Tablet thickness incl. case (mm)
let width = 40.0; // [25.0, 60.0] Bracket width (mm)
const t = 3.0;
let back = box_from_corners([0, 0, 0], [width, t, 50.0]);
let floor = box_from_corners([0, t - 0.01, 0], [width, t + tablet + t, t]);
let lip = box_from_corners([0, t + tablet, t - 0.01], [width, t + tablet + t, t + 10.0]);
let b = back + floor + lip;
let b = b.fillet(1.0, b.edges("|X"));
let holes = [];
for x in [width / 4.0, 3.0 * width / 4.0] {
    holes.push(cylinder([x, -1.0, 35.0], "Y", 2.0, t + 2.0));
    holes.push(cone(4.0, 2.0, 2.0).rotate_x(90.0).translate([x, t + 0.01, 35.0]));
}
b - fuse_all(holes)
