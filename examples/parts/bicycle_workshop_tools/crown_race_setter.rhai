// Crown race setter for 1 1/8 in steerers: 41.6 mm tube 120 mm long, 29.0 mm bore over the steerer, 30.6 mm counterbore 3 mm deep to land on the race, 8 mm thick closed striking cap with a 1 mm chamfer
let steerer_d = 28.6; // [25.4, 38.1] Steerer diameter (mm)
let length = 120.0; // [80.0, 200.0] Setter length (mm)
let wall = 5.5; // [4.0, 8.0] Wall thickness (mm)
const cap_t = 8.0;
let bore = steerer_d + 0.4;
let od = steerer_d + 2.0 + 2.0 * wall;
let tube = cylinder(od / 2.0, length);
let tube = tube.chamfer(1.0, tube.edges(">Z or <Z"));
let cuts = fuse_all([
    cylinder([0, 0, -1.0], "Z", bore / 2.0, length - cap_t + 1.0),
    cylinder([0, 0, -1.0], "Z", bore / 2.0 + 0.8, 4.0),
]);
tube - cuts
