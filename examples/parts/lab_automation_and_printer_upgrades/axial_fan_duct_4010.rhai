// Part cooling duct for a 40 x 40 x 10 mm axial fan: 40 mm mounting plate 3 mm with 4 x M3 holes on 32 mm and a 38 mm opening, 22 mm tall tapered duct offset 15 mm sideways ending in a 26 x 8 mm outlet, 1.5 mm walls
let fan = 40.0; // [30.0, 60.0] Fan size (mm)
let duct_h = 22.0; // [12.0, 40.0] Duct height (mm)
let offset = 15.0; // [0.0, 25.0] Outlet offset (mm)
let outlet_w = 26.0; // [12.0, 36.0] Outlet width (mm)
let outlet_h = 8.0; // [6.0, 14.0] Outlet height (mm)
const wall = 1.5;
const plate_t = 3.0;
let hole_pitch = fan * 0.8;
let a0 = fan - 2.0;
let z0 = plate_t;
let z1 = plate_t + duct_h;
let ow = min(outlet_w, a0);
let plate = box_centered(fan, fan, plate_t).translate([0, 0, plate_t / 2.0]).fillet(3.0, "|Z");
let outer = loft([rect(plane([0, 0, z0], [0, 0, 1]), a0, a0), rect(plane([offset, 0, z1], [0, 0, 1]), ow, outlet_h)], true);
// the inner loft is the same ruled surface inset by the wall, extended 0.5 mm past both ends
let iw0 = a0 - 2.0 * wall;
let iw1 = ow - 2.0 * wall;
let ih1 = outlet_h - 2.0 * wall;
let k = 0.5 / duct_h;
let inner = loft([
    rect(plane([-offset * k, 0, z0 - 0.5], [0, 0, 1]), iw0 - (iw1 - iw0) * k, iw0 - (ih1 - iw0) * k),
    rect(plane([offset * (1.0 + k), 0, z1 + 0.5], [0, 0, 1]), iw1 + (iw1 - iw0) * k, ih1 + (ih1 - iw0) * k)], true);
let duct = plate + outer - inner - cylinder([0, 0, -1], "Z", fan * 0.45, plate_t + 0.75);
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        holes.push(cylinder([sx * hole_pitch / 2.0, sy * hole_pitch / 2.0, -1], "Z", 1.6, plate_t + 2.0));
    }
}
duct - compound(holes)
