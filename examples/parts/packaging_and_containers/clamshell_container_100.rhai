// Hinged clamshell food container, 100 x 100 mm, as moulded open: 30 mm deep base tray and 20 mm lid tray, 1 mm walls, 8 mm corner radius, 5 mm flanges joined by a 6 mm living hinge with a 0.4 mm web
let size = 100.0; // [60.0, 200.0] Tray size (mm)
let base_depth = 30.0; // [10.0, 60.0] Base tray depth (mm)
let lid_depth = 20.0; // [5.0, 50.0] Lid tray depth (mm)
let wall = 1.0; // [0.6, 2.0] Wall thickness (mm)
let flange = 5.0; // [3.0, 10.0] Flange width (mm)
let corner = 8.0; // [4.0, 20.0] Corner radius (mm)
let hinge_width = 6.0; // [3.0, 10.0] Hinge width (mm)
fn tray(size, depth, wall, flange, corner) {
    let outer = box_centered(size, size, depth).fillet(corner, "|Z").fillet(min(4.0, depth / 3.0), "<Z").translate([0, 0, -depth / 2.0]);
    let inner = box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).fillet(corner - wall, "|Z").fillet(min(4.0, depth / 3.0) - wall, "<Z").translate([0, 0, -depth / 2.0 + wall]);
    let rim = box_centered(size + 2.0 * flange, size + 2.0 * flange, wall).fillet(corner + flange, "|Z").translate([0, 0, -wall / 2.0]);
    (outer + rim) - inner
}
let c = max(corner, wall + 2.0);
let base = tray(size, base_depth, wall, flange, c);
let half = size / 2.0 + flange;
let lid = tray(size, lid_depth, wall, flange, c).translate([0, 2.0 * half + hinge_width, 0]);
// living hinge: a strip bridging the two flanges with a thin web in the middle
let hinge = box_from_corners([-size * 0.4, half - 1.0, -wall], [size * 0.4, half + hinge_width + 1.0, 0]);
hinge = hinge - box_from_corners([-size, half + hinge_width / 2.0 - 0.6, -wall + 0.4], [size, half + hinge_width / 2.0 + 0.6, 1.0]);
fuse_all([base, lid, hinge])
