// Windscreen wiper arm pivot nut cover: 38 x 20 x 14 mm hinged cap, round nose, 1.6 mm wall, two 3 mm snap pins 1.2 mm proud at the hinge end
let length = 38.0; // [30.0, 50.0] Cap length (mm)
let width = 20.0; // [16.0, 26.0] Cap width (mm)
let height = 14.0; // [10.0, 20.0] Cap height (mm)
let wall = 1.6; // [1.2, 2.5] Wall (mm)

const pin_r = 1.5;
let rounded = |l, w, h, top_r| {
    let b = box_from_corners([0, -w / 2.0, 0], [l, w / 2.0, h]);
    b = b.fillet(w / 2.0 - 0.5, b.edges("|Z and >X"));
    b = b.fillet(2.0, b.edges("|Z and <X"));
    b.fillet(top_r, b.edges(">Z"))
};
let outer = rounded.call(length, width, height, 3.0);
let inner = rounded.call(length - 2.0 * wall, width - 2.0 * wall, height - wall + 1.0, 1.8).translate([wall, 0, -1.0]);
let cap = outer - inner;
// hinge pins on the inside of the side walls
let pins = [];
for s in [-1.0, 1.0] {
    let y0 = if s < 0.0 { -(width / 2.0 - wall + 0.5) } else { width / 2.0 - wall - 1.2 };
    pins.push(cylinder([5.0, y0, 4.0], "Y", pin_r, 1.7));
}
cap + fuse_all(pins)
