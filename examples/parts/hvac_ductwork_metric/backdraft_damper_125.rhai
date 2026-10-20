// 125 mm inline backdraft damper: 124 mm OD housing 120 mm long with 1.5 mm wall, 4 mm stop ring, two half-disc butterfly flaps 1.2 mm on a 4 mm centre spindle, shown partly open
let duct_d = 124.0; // [80.0, 200.0] Housing outside diameter (mm)
let length = 120.0; // [100.0, 200.0] Housing length (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let open_angle = 30.0; // [0.0, 60.0] Flap opening angle (degrees)
const ring_w = 4.0;
const flap_t = 1.2;
const pivot_z = 40.0;
let ro = duct_d / 2.0;
let ri = ro - wall;
let housing = cylinder(ro, length) - cylinder([0, 0, -1], "Z", ri, length + 2.0);
let ring = cylinder([0, 0, pivot_z - 5.0], "Z", ri + 0.5, 4.0) - cylinder([0, 0, pivot_z - 6.0], "Z", ri - ring_w, 6.0);
let spindle = cylinder([-(ri + 0.5), 0, pivot_z], "X", 2.0, 2.0 * ri + 1.0);
let rf = ri - 1.0;
let disc = cylinder([0, 0, pivot_z - 1.0], "Z", rf, flap_t);
let flap_a = (disc & box_from_corners([-rf - 1.0, 0, pivot_z - 2.0], [rf + 1.0, rf + 1.0, pivot_z + 1.0])).rotate([0, 0, pivot_z], "X", open_angle);
let flap_b = (disc & box_from_corners([-rf - 1.0, -rf - 1.0, pivot_z - 2.0], [rf + 1.0, 0, pivot_z + 1.0])).rotate([0, 0, pivot_z], "X", -open_angle);
fuse_all([housing, ring, spindle, flap_a, flap_b])
