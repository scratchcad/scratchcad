// Tablet size gauge plate for identifying round tablets: 3 mm plate with 11 through holes from 4 mm to 14 mm in 1 mm steps, 4 mm apart edge to edge, 26 mm wide with a 6 mm margin, 5 mm rounded corners and a 0.5 mm chamfer on every hole
let smallest = 4.0; // [2.0, 6.0] Smallest hole (mm)
let step = 1.0; // [0.5, 2.0] Size step (mm)
let holes = 11; // [5, 15] Number of hole sizes
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
const gap = 4.0;
const margin = 6.0;
let largest = smallest + (holes - 1) * step;
let width = largest + 12.0;
let span = holes * gap + holes * smallest + step * holes * (holes - 1) / 2.0;
let length = span - gap + 2.0 * margin;
let plate = box_from_corners([0, 0, 0], [length, width, thickness]);
let plate = plate.fillet(5.0, plate.edges("|Z"));
let cutters = [];
for i in 0..holes {
    let d = smallest + i * step;
    let x = margin + i * gap + i * smallest + step * i * (i - 1) / 2.0 + d / 2.0;
    cutters.push(cylinder([x, width / 2.0, -1.0], "Z", d / 2.0, thickness + 2.0));
}
let gauge = plate - fuse_all(cutters);
gauge.chamfer(0.5, gauge.edges("%CIRCLE").filter(|e| e.length() > 6.0 * e.radius()))
