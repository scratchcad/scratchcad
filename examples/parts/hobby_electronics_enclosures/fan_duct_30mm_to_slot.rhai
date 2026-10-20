// 30 mm fan to slot duct for blowing over a row of stepper drivers: 30 x 30 x 3 mm flange with M3 holes on 24 mm square, 25 mm round inlet lofted 25 mm to a 44 x 6 mm outlet slot, 1.2 mm walls
let fan = 30.0; // [25.0, 40.0] Fan size (mm)
let hole_spacing = 24.0; // [20.0, 32.0] Fan hole spacing (mm)
let length = 25.0; // [15.0, 50.0] Duct length (mm)
let slot_w = 44.0; // [25.0, 60.0] Outlet slot width (mm)
let slot_h = 6.0; // [4.0, 12.0] Outlet slot height (mm)
let wall = 1.2; // [0.8, 2.0] Duct wall (mm)
const flange_t = 3.0;
let hs = min(hole_spacing, fan - 5.0);
let ri = min(fan / 2.0 - 1.5 - wall, hs / 2.0 * 1.414 - 2.5);
let flange = box_centered(fan, fan, flange_t).translate([0, 0, flange_t / 2.0]);
let flange = flange.fillet(2.5, flange.edges("|Z"));
let outer = loft([circle([0, 0, flange_t - 0.5], [0, 0, 1], ri + wall), rect(plane([0, 0, flange_t + length], [0, 0, 1]), slot_w + 2.0 * wall, slot_h + 2.0 * wall)], true);
let inner = loft([circle([0, 0, flange_t - 1.0], [0, 0, 1], ri), rect(plane([0, 0, flange_t + length + 0.5], [0, 0, 1]), slot_w, slot_h)], true);
let holes = [];
for x in [-hs / 2.0, hs / 2.0] {
    for y in [-hs / 2.0, hs / 2.0] {
        holes.push(cylinder([x, y, -1], "Z", 1.7, flange_t + 2.0));
    }
}
(flange + outer) - inner - cylinder([0, 0, -1], "Z", ri, flange_t + 1.0) - compound(holes)
