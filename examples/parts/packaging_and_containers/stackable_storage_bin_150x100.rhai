// Nesting storage bin, 150 x 100 mm base flaring to 160 x 110 mm at an 80 mm rim, 2 mm walls, 10 mm corner radius, 4 mm stacking lip and a 50 x 18 mm hand slot in the front
let base_length = 150.0; // [80.0, 300.0] Base length (mm)
let base_width = 100.0; // [50.0, 200.0] Base width (mm)
let height = 80.0; // [40.0, 200.0] Height (mm)
let flare = 5.0; // [0.0, 15.0] Wall flare per side (mm)
let wall = 2.0; // [1.2, 4.0] Wall thickness (mm)
let corner = 10.0; // [4.0, 25.0] Corner radius (mm)
fn rr(l, w, r, z) {
    rect(l - 2.0 * r, w - 2.0 * r).offset(r).translate([0, 0, z])
}
let r = max(corner, wall + 2.0);
let outer = loft([rr(base_length, base_width, r, 0), rr(base_length + 2.0 * flare, base_width + 2.0 * flare, r + flare * 0.3, height)], true);
let s = flare / height;
let inner = loft([rr(base_length - 2.0 * wall, base_width - 2.0 * wall, r - wall, wall), rr(base_length + 2.0 * flare * (1.0 + 1.0 / height) - 2.0 * wall, base_width + 2.0 * flare * (1.0 + 1.0 / height) - 2.0 * wall, r + flare * 0.3 - wall, height + 1.0)], true);
let bin = outer - inner;
// stacking lip around the rim
let lip = face(rr(base_length + 2.0 * flare + 8.0, base_width + 2.0 * flare + 8.0, r + 4.0, 0)) - face(rr(base_length + 2.0 * flare - 1.0, base_width + 2.0 * flare - 1.0, r + flare * 0.3 - 0.5, 0));
bin = bin + lip.extrude([0, 0, 3.0]).translate([0, 0, height - 3.0]);
// hand slot through the front (-Y) wall
let slot = face(rect(32.0, 0.01).offset(9.0)).rotate_x(90.0).extrude([0, 30.0, 0]).translate([0, -base_width / 2.0 - flare - 15.0, height - 18.0]);
bin - slot
