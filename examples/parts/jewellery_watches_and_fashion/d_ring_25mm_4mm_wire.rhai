// Bag strap D-ring for 25 mm webbing: 4 mm round wire, 25 mm straight bar inside, D rising 15.5 mm, 3 mm corner radii
let inside_width = 25.0; // [15.0, 50.0] Inside width (mm)
let wire_diameter = 4.0; // [2.0, 6.0] Wire diameter (mm)
let corner_radius = 3.0; // [1.5, 6.0] Corner radius (mm)
let rw = wire_diameter / 2.0;
// centreline: straight bar on y = 0, corner arcs, and a half circle over the top
let half = inside_width / 2.0 + rw;
let rc = min(corner_radius + rw, half - 1.0);
let xs = half - rc;
const k = 0.7071;
let path = wire([
    line([0, 0, 0], [xs, 0, 0]),
    arc([xs, 0, 0], [xs + rc * k, rc - rc * k, 0], [half, rc, 0]),
    arc([half, rc, 0], [0, rc + half, 0], [-half, rc, 0]),
    arc([-half, rc, 0], [-xs - rc * k, rc - rc * k, 0], [-xs, 0, 0]),
    line([-xs, 0, 0], [0, 0, 0]),
]);
circle([0, 0, 0], [1, 0, 0], rw).to_face().sweep(path).translate([0, 0, rw])
