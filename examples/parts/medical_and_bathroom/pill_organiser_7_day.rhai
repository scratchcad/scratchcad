// 7-day pill organiser tray: seven 25 x 30 mm compartments 20 mm deep with scooped floors, 1.5 mm walls, tactile day dots (1 to 7) on the front
let days = 7; // [1, 14] Number of compartments
let cell_width = 25.0; // [15.0, 40.0] Compartment width (mm)
let cell_length = 30.0; // [20.0, 50.0] Compartment length front to back (mm)
let depth = 20.0; // [10.0, 35.0] Compartment depth (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let pitch = cell_width + wall;
let length = days.to_float() * pitch + wall;
let tray = box(length, cell_length + 2.0 * wall, depth + wall).fillet(3.0, "|Z");
let scoop = min(8.0, min(cell_length, depth) * 0.4);
let cells = [];
let dots = [];
for i in 0..days {
    let x = wall + i.to_float() * pitch;
    cells.push(box(cell_width, cell_length, depth + 5.0).fillet(scoop, "<Z and |X").translate([x, wall, wall]));
    let n = i + 1;
    for k in 0..n {
        let col = k % 4;
        let row = k / 4;
        dots.push(sphere([x + cell_width / 2.0 + (col.to_float() - 1.5) * 4.5, 0.2, depth * 0.55 + wall - row.to_float() * 4.5], 1.0));
    }
}
fuse_all([tray - compound(cells)] + dots)
