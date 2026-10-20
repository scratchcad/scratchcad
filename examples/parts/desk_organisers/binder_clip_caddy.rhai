// Binder clip caddy with 3 sized compartments for 51, 32 and 19 mm clips: 162 x 70 mm, 35 mm deep, 2.5 mm walls, compartments 70, 50 and 32 mm long, rounded inside floor edges, front label strip
let depth = 70.0; // [50.0, 100.0] Caddy depth (mm)
let height = 35.0; // [20.0, 60.0] Caddy height (mm)
let large = 70.0; // [50.0, 100.0] Large compartment length (mm)
let medium = 50.0; // [35.0, 80.0] Medium compartment length (mm)
let small = 32.0; // [20.0, 60.0] Small compartment length (mm)

const wall = 2.5;
const floor_t = 2.5;
let lens = [large, medium, small];
let length = large + medium + small + 4.0 * wall;
let caddy = box_from_corners([0, 0, 0], [length, depth, height]);
caddy = caddy.fillet(6.0, caddy.edges("|Z"));
let x = wall;
let pockets = [];
for l in lens {
    let p = box_from_corners([x, wall, floor_t], [x + l, depth - wall, height + 5.0]);
    p = p.fillet(4.0, p.edges("|Z"));
    p = p.fillet(5.0, p.edges("<Z"));
    pockets.push(p);
    x += l + wall;
}
caddy = caddy - compound(pockets);
caddy - box_from_corners([10.0, -1.0, height - 12.0], [length - 10.0, 0.6, height - 4.0])
