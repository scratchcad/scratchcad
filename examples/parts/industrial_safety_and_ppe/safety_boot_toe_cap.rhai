// Safety boot toe cap: EN ISO 20345 200 J composite toe cap, 95 mm wide, 70 mm deep, 45 mm tall, 4 mm wall, barrel dome (sphere crossed with a cylinder) cut flat at the heel side with a 10 mm sole flange
let width = 95.0; // [80.0, 110.0] Cap width (mm)
let depth = 70.0; // [55.0, 85.0] Cap depth (mm)
let height = 45.0; // [35.0, 55.0] Cap height (mm)
let wall = 4.0; // [3.0, 6.0] Wall thickness (mm)
let flange = 10.0; // [6.0, 14.0] Sole flange width (mm)
// dome: sphere sized to the cap depth, cylinder (axis Y) sized to the width
let rs = (depth * depth + height * height) / (2.0 * height);
let rc = (width * width / 4.0 + height * height) / (2.0 * height);
let outer = sphere([0, 0, height - rs], rs) & cylinder([0, -rs, height - rc], "Y", rc, 2.0 * rs);
let inner = sphere([0, 0, height - rs], rs - wall) & cylinder([0, -rs, height - rc], "Y", rc - wall, 2.0 * rs);
let half = box_from_corners([-width, 0, 0], [width, depth + 10.0, height + 5.0]);
let cap = (outer - inner) & half;
let ring = (cylinder(depth + flange, 1.5) & box_from_corners([-width / 2.0 - flange, 0, -1.0], [width / 2.0 + flange, depth + flange + 1.0, 3.0])) - (outer & half);
cap + ring
