// IPE 100 steel I-beam
let length = 500.0; // [100, 3000] Length (mm)
let height = 100.0; let width = 55.0; let web = 4.1; let flange = 5.7; let root = 7.0;
let profile = box_centered(width, height, length).translate([0, 0, length / 2.0])
    - box_from_corners([web / 2.0, -height / 2.0 + flange, -1], [width, height / 2.0 - flange, length + 1])
    - box_from_corners([-width, -height / 2.0 + flange, -1], [-web / 2.0, height / 2.0 - flange, length + 1]);
profile.fillet(root, "|Z and not (>X or <X)").rotate_x(-90).rotate_z(90).translate([0, 0, height / 2.0])
