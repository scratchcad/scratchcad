// Knee pad hard shell: 180 x 130 mm domed cap 45 mm high, 4 mm wall, barrel-shaped (sphere crossed with a cylinder), two 30 x 8 mm strap slots each side
let length = 180.0; // [150.0, 220.0] Shell length (mm)
let width = 130.0; // [100.0, 160.0] Shell width (mm)
let height = 45.0; // [30.0, 60.0] Dome height (mm)
let wall = 4.0; // [3.0, 6.0] Wall thickness (mm)
// sphere radius from the long chord, cylinder radius from the short chord
let rs = (length * length / 4.0 + height * height) / (2.0 * height);
let rc = (width * width / 4.0 + height * height) / (2.0 * height);
let outer = sphere([0, 0, height - rs], rs) & cylinder([-rs, 0, height - rc], "X", rc, 2.0 * rs);
let inner = sphere([0, 0, height - rs], rs - wall) & cylinder([-rs, 0, height - rc], "X", rc - wall, 2.0 * rs);
let keep = box_centered(length + 20.0, width + 20.0, height + 10.0).translate([0, 0, (height + 10.0) / 2.0]);
let shell = (outer - inner) & keep;
let slots = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] {
    slots.push(box_centered(30.0, 8.0, 40.0).translate([sx * length * 0.22, sy * (width / 2.0 - 12.0), 10.0]));
} }
shell - compound(slots)
