// Ice cube tray, 12 cubes: 4 x 3 tapered cavities 32 mm square at the top, 26 mm at the bottom, 25 mm deep, 4 mm walls between, 2 mm floor, 3 mm lip
let columns = 4; // [2, 8] Cavities along the length
let rows = 3; // [1, 4] Cavities across
let cube_top = 32.0; // [20.0, 45.0] Cavity size at the top (mm)
let cube_bottom = 26.0; // [15.0, 40.0] Cavity size at the bottom (mm)
let depth = 25.0; // [15.0, 40.0] Cavity depth (mm)
let divider = 4.0; // [2.0, 8.0] Wall between cavities (mm)
let floor_thickness = 2.0; // [1.0, 4.0] Floor thickness (mm)
let pitch = cube_top + divider;
let length = columns.to_float() * pitch + divider;
let width = rows.to_float() * pitch + divider;
let h = depth + floor_thickness;
let tray = box_centered(length, width, h).translate([0, 0, h / 2.0]).fillet(4.0, "|Z");
tray = tray + (box_centered(length + 6.0, width + 6.0, 3.0).translate([0, 0, h - 1.5]).fillet(5.0, "|Z"));
let bottom = min(cube_bottom, cube_top);
// two sections only, the top one 1 mm above the rim on the same taper (a loft through unevenly spaced
// sections overshoots)
let over = cube_top + (cube_top - bottom) / depth;
let cavity = loft([rect(bottom, bottom).translate([0, 0, floor_thickness]), rect(over, over).translate([0, 0, h + 1.0])], true);
let cavities = [];
for i in 0..columns {
    for j in 0..rows {
        cavities.push(cavity.translate([(i.to_float() - (columns - 1).to_float() / 2.0) * pitch, (j.to_float() - (rows - 1).to_float() / 2.0) * pitch, 0]));
    }
}
tray - compound(cavities)
