// Reversible cultivator S-tine point: 8 mm plate 150 mm long and 45 mm wide, pointed at both ends over 35 mm so it can be turned round when worn, with 3 mm bevels along the four top cutting edges, and two 10.5 mm holes 35 mm apart for M10 plough bolts
let length = 150.0; // [110.0, 200.0] Point length (mm)
let width = 45.0; // [32.0, 60.0] Point width (mm)
let thickness = 8.0; // [6.0, 12.0] Plate thickness (mm)
let point_len = 35.0; // [20.0, 50.0] Pointed end length (mm)
let hole_pitch = 35.0; // [25.0, 50.0] Bolt hole spacing (mm)
const bolt_d = 10.5;
let l = length / 2.0;
let w = width / 2.0;
let p = min(point_len, l - 20.0);
let t = thickness;
let plate = polygon([[-l, 0, 0], [-l + p, -w, 0], [l - p, -w, 0], [l, 0, 0], [l - p, w, 0], [-l + p, w, 0]]).to_face().extrude([0, 0, t]);
let bevel = min(3.0, t - 3.0);
let plate = plate.chamfer(bevel, plate.edges("not |X").filter(|e| e.center().z > t - 0.1));
let hp = min(hole_pitch, 2.0 * (l - p) - 4.0);
plate - fuse_all([
    cylinder([-hp / 2.0, 0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
    cylinder([hp / 2.0, 0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
])
