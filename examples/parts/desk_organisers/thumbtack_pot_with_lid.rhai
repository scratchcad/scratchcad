// Thumbtack and drawing pin pot with lid, two bodies: 60 mm round pot 40 mm tall, 2 mm wall, 3 mm floor, 6 mm push-fit spigot ring; 64 mm lid 8 mm tall with a 20 mm grip knob, printed side by side
let diameter = 60.0; // [40.0, 90.0] Pot diameter (mm)
let height = 40.0; // [25.0, 70.0] Pot height (mm)
let wall = 2.0; // [1.6, 3.0] Wall (mm)
let fit = 0.25; // [0.1, 0.5] Lid fit clearance (mm)
let knob = 20.0; // [12.0, 30.0] Knob diameter (mm)

const floor_t = 3.0;
const spigot = 6.0;
const lid_t = 2.5;
let r = diameter / 2.0;
// pot with a stepped-in spigot at the top
let pot = cylinder(r, height - spigot) + cylinder([0, 0, height - spigot - 0.5], "Z", r - wall, spigot + 0.5);
pot = pot - cylinder([0, 0, floor_t], "Z", r - 2.0 * wall, height);
pot = pot.chamfer(0.8, pot.edges("<Z"));
// lid: a cap whose skirt slides over the spigot
let lr = r;
let lid = cylinder(lr, lid_t + spigot - 1.0) - cylinder([0, 0, lid_t], "Z", r - wall + fit, spigot + 1.0);
let k = min(knob, diameter * 0.6);
let grip = cylinder([0, 0, -8.0], "Z", k / 2.0, 8.5);
grip = grip.chamfer(1.0, grip.edges("<Z"));
lid = (lid + grip).rotate_x(180.0).translate([diameter + 10.0, 0, lid_t + spigot - 1.0]);
compound([pot, lid])
