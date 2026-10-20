// 90 degree angle bracket for mounting a TS35 rail off a cabinet side wall: 4 mm steel, 50 mm wide, 40 mm wall leg with two 6.5 mm holes on 30 mm, 50 mm rail leg with a 5.3 x 15 mm slot 6 mm beyond the gusset for the rail screw, 25 mm triangular gusset 3 mm thick
let width = 50.0; // [30.0, 80.0] Bracket width (mm)
let wall_leg = 40.0; // [25.0, 80.0] Wall leg length (mm)
let rail_leg = 50.0; // [45.0, 80.0] Rail leg length (mm)
let t = 4.0; // [3.0, 6.0] Plate thickness (mm)
const gusset = 25.0;
let base = box_from_corners([0, -width / 2.0, 0], [rail_leg, width / 2.0, t]);
let wall = box_from_corners([0, -width / 2.0, 0], [t, width / 2.0, wall_leg]);
let g = face(polygon([[t - 0.5, -1.5, t - 0.5], [t + gusset, -1.5, t - 0.5], [t - 0.5, -1.5, t + gusset]])).extrude([0, 3.0, 0]);
let b = base + wall + g;
let b = b.fillet(4.0, b.edges("|X and >Z") + b.edges("|Z and >X"));
let holes = [];
for s in [-1.0, 1.0] {
    holes.push(cylinder([-1.0, s * 15.0, wall_leg / 2.0 + t / 2.0 + 4.0], "X", 3.25, t + 2.0));
}
let sx = t + gusset + 6.0;
let slot = box_centered(5.3, 15.0 - 5.3, t + 2.0).translate([sx, 0, t / 2.0])
    + cylinder([sx, -(15.0 - 5.3) / 2.0, -1.0], "Z", 2.65, t + 2.0) + cylinder([sx, (15.0 - 5.3) / 2.0, -1.0], "Z", 2.65, t + 2.0);
b - fuse_all(holes) - slot
