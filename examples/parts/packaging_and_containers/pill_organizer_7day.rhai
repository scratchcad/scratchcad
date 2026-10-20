// Seven-day pill organizer base: seven 22 x 25 mm compartments 18 mm deep with rounded floors, 1.5 mm walls, and a 3 mm hinge rail along the back with knuckle gaps for the flip lids
let compartments = 7; // [3, 14] Number of compartments
let cell_width = 22.0; // [12.0, 35.0] Compartment width (mm)
let cell_depth = 25.0; // [15.0, 40.0] Compartment front-to-back depth (mm)
let cell_height = 18.0; // [10.0, 30.0] Compartment height (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let floor_radius = 5.0; // [1.0, 8.0] Floor fillet radius (mm)
let n = compartments.to_float();
let length = n * (cell_width + wall) + wall;
let depth = cell_depth + 2.0 * wall;
let h = cell_height + wall;
let tray = box_from_corners([0, 0, 0], [length, depth, h]).fillet(2.0, "|Z");
let cells = [];
for i in 0..compartments {
    let x0 = wall + i.to_float() * (cell_width + wall);
    cells.push(box_from_corners([x0, wall, wall], [x0 + cell_width, wall + cell_depth, h + 1.0]).fillet(min(floor_radius, cell_height - 1.0), "<Z"));
}
tray = tray - compound(cells);
// hinge rail on the back top edge
let rail = cylinder([0, depth + 1.2, h - 1.5], "X", 1.5, length) + box_from_corners([0, depth - 0.5, h - 3.0], [length, depth + 1.2, h]);
let gaps = [];
for i in 0..compartments {
    let xc = wall + (i.to_float() + 0.5) * (cell_width + wall);
    gaps.push(box_centered(cell_width * 0.4, 6.0, 6.0).translate([xc, depth + 2.0, h - 1.5]));
}
tray + (rail - compound(gaps))
