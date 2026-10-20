// Vertical garden gutter bracket: wall bracket carrying a 115 mm half-round gutter planter, 5 mm thick hook profile 40 mm wide, 118 mm cradle radius with 6 mm front bead clip, two 5 mm countersunk screw holes in a 70 mm back plate that rises above the cradle
// # Gutter
let gutter = 115.0; // [75.0, 150.0] Gutter width (mm)
let width = 40.0; // [25.0, 60.0] Bracket width (mm)
let thickness = 5.0; // [5.0, 8.0] Bracket thickness (mm)
// # Wall plate
let plate_h = 70.0; // [50.0, 100.0] Back plate height (mm)
let screw = 5.0; // [4.0, 6.0] Screw diameter (mm)
let rc = gutter / 2.0 + 1.5;
let cx = rc + thickness * 0.5;
let cradle = cylinder([cx, 0, 0], "Z", rc + thickness, width) - cylinder([cx, 0, -1.0], "Z", rc, width + 2.0) - box_from_corners([-cx, 0.0, -1.0], [cx * 3.0, cx * 2.0, width + 1.0]) - box_from_corners([-cx, -cx * 2.0, -1.0], [0, cx * 2.0, width + 1.0]);
let plate = box_from_corners([0, -12.0, 0], [thickness, plate_h - 12.0, width]).fillet(min(width / 2.0 - 1.0, 10.0), "|X and >Y");
let bead = box_from_corners([cx + rc + 0.5, -3.0, 0], [cx + rc + thickness, 8.0, width]).fillet(2.0, "|Z and >Y");
let lip = box_from_corners([cx + rc - 3.0, 5.0, 0], [cx + rc + thickness, 8.0, width]);
let holes = [];
for z in [width * 0.3, width * 0.7] {
    let y = plate_h - 30.0;
    holes.push(cylinder([-1.0, y, z], "X", screw / 2.0 + 0.2, thickness + 2.0));
    holes.push(cone(screw / 2.0 + 0.2, screw + 0.4, screw / 2.0 + 0.2).rotate_y(90.0).translate([thickness - screw / 2.0 - 0.19, y, z]));
}
(cradle + plate + bead + lip) - fuse_all(holes)
