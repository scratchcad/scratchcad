// Rotating pen carousel, two bodies: 100 mm base disc 8 mm thick with an 8 mm pivot pin and a 3 mm bearing ring; 92 mm carousel 90 mm tall with 6 wedge compartments around a 20 mm hub, 2 mm walls, pivot socket 8.4 mm
let diameter = 92.0; // [70.0, 130.0] Carousel diameter (mm)
let height = 90.0; // [60.0, 130.0] Carousel height (mm)
let compartments = 6; // [3, 10] Number of compartments
let wall = 2.0; // [1.6, 3.0] Wall (mm)
let pin = 8.0; // [6.0, 12.0] Pivot pin diameter (mm)

const base_t = 8.0;
const floor_t = 3.0;
let r = diameter / 2.0;
let hub_r = max(10.0, pin / 2.0 + 4.0);
// base
let base = cylinder(r + 4.0, base_t);
base = base.chamfer(1.5, base.edges(">Z and %CIRCLE").filter(|e| e.radius() > r));
base = base + cylinder([0, 0, base_t - 0.5], "Z", pin / 2.0, 14.5) + (cylinder([0, 0, base_t - 0.5], "Z", r - 6.0, 2.0) - cylinder([0, 0, base_t - 1.0], "Z", r - 9.0, 3.0));
// carousel
let cup = cylinder(r, height);
let annulus = cylinder([0, 0, floor_t], "Z", r - wall, height) - cylinder([0, 0, floor_t - 1.0], "Z", hub_r + wall, height + 2.0);
let dividers = [];
for i in 0..compartments {
    dividers.push(box_from_corners([0, -wall / 2.0, 0], [r + 1.0, wall / 2.0, height + 1.0]).rotate_z(i * 360.0 / compartments));
}
cup = cup - (annulus - fuse_all(dividers));
cup = cup - cylinder([0, 0, -1.0], "Z", pin / 2.0 + 0.2, 16.0) - (cylinder([0, 0, -1.0], "Z", r - 5.5, 3.0) - cylinder([0, 0, -2.0], "Z", r - 9.5, 5.0));
compound([base, cup.translate([2.0 * r + 15.0, 0, 0])])
