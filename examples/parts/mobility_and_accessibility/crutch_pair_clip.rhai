// Crutch pair clip: twin snap clip that holds two 22 mm forearm crutches together when standing, 25 mm tall, two C-rings with 3 mm wall and 15.5 mm mouths facing outward, 4 mm web and a hanging hook for a bag
// # Tubes
let tube = 22.0; // [19.0, 25.0] Crutch tube diameter (mm)
let height = 25.0; // [15.0, 40.0] Clip height (mm)
let wall = 3.0; // [2.5, 4.0] Wall thickness (mm)
// # Detail
let web = 4.0; // [2.0, 10.0] Web between rings (mm)
let mouth = 0.7; // [0.6, 0.8] Mouth opening (fraction of tube diameter)
let r = tube / 2.0 + 0.2;
let ro = r + wall;
let cx = ro + web / 2.0 - wall / 2.0;
let parts = [];
for s in [-1.0, 1.0] {
    let ring = cylinder([s * cx, 0, 0], "Z", ro, height) - cylinder([s * cx, 0, -1.0], "Z", r, height + 2.0);
    let gap = if s > 0.0 { box_from_corners([cx + r * 0.3, -tube * mouth / 2.0, -1.0], [cx + ro + 1.0, tube * mouth / 2.0, height + 1.0]) } else { box_from_corners([-cx - ro - 1.0, -tube * mouth / 2.0, -1.0], [-cx - r * 0.3, tube * mouth / 2.0, height + 1.0]) };
    parts.push(ring - gap);
}
let bridge = box_from_corners([-cx + r - 0.5, -wall, 0], [cx - r + 0.5, wall, height]);
let hook = box_from_corners([-2.5, -ro - 10.0, 0], [2.5, -wall + 0.01, 6.0]) + box_from_corners([-2.5, -ro - 10.0, 0], [2.5, -ro - 6.0, 14.0]);
let body = fuse_all(parts) + bridge + hook;
body - cylinder([-cx, 0, -1.0], "Z", r, height + 2.0) - cylinder([cx, 0, -1.0], "Z", r, height + 2.0)
