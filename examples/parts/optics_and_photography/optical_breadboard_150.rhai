// Thorlabs MB1515/M aluminium breadboard: 150 x 150 x 12.7 mm, M6 tapped holes on a 25 mm grid starting 12.5 mm from the edges, four counterbored M6 mounting holes
let size = 150.0; // [75.0, 300.0] Breadboard width and length (mm)
let thickness = 12.7; // [8.0, 20.0] Thickness (mm)
let grid = 25.0; // [12.5, 50.0] Hole spacing (mm)
let edge_chamfer = 1.0; // [0.2, 2.0] Edge chamfer (mm)
let board = box_centered(size, size, thickness).translate([0, 0, thickness / 2.0]);
board = board.chamfer(edge_chamfer);
let n = (size / grid).floor().to_int();
let start = -(n - 1).to_float() * grid / 2.0;
let holes = [];
for i in 0..n {
    for j in 0..n {
        let x = start + i.to_float() * grid;
        let y = start + j.to_float() * grid;
        holes.push(cylinder([x, y, -1.0], "Z", 2.5, thickness + 2.0) + cone(3.6, 2.4, 1.2).translate([x, y, thickness - 1.19]));
    }
}
// counterbored mounting holes between the grid rows near the corners
let m = start + grid / 2.0;
for x in [-m, m] {
    for y in [-m, m] {
        holes.push(cylinder([x, y, -1.0], "Z", 3.3, thickness + 2.0) + cylinder([x, y, thickness - 6.5], "Z", 5.5, 7.0));
    }
}
board - compound(holes)
