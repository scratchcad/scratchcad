// Boot floor panel recessed finger pull: 100 x 48 mm flange 2.5 mm, 80 x 30 mm finger cup 16 mm deep with 2 mm walls for an 18 mm board, sloped back wall, 2 countersunk 3.5 mm screws
let length = 80.0; // [60.0, 110.0] Cup length (mm)
let width = 30.0; // [22.0, 40.0] Cup width (mm)
let depth = 16.0; // [10.0, 24.0] Cup depth (mm)
let flange = 10.0; // [6.0, 14.0] Flange margin (mm)
let wall = 2.0; // [1.6, 3.0] Wall (mm)

const flange_t = 2.5;
let fl = box_centered(length + 2.0 * flange, width + 2.0 * flange, flange_t).translate([0, 0, -flange_t / 2.0]);
fl = fl.fillet(flange + 2.0, fl.edges("|Z"));
fl = fl.fillet(1.2, fl.edges(">Z"));
let cup_out = box_centered(length + 2.0 * wall, width + 2.0 * wall, depth + 1.0).translate([0, 0, -flange_t - (depth + 1.0) / 2.0 + 1.0]);
cup_out = cup_out.fillet(width / 2.0, cup_out.edges("|Z"));
let pull = fl + cup_out;
// finger pocket with a sloped back wall so the finger hooks under the near edge
let pocket = box_centered(length, width, depth + 2.0).translate([0, 0, -(depth + 2.0) / 2.0 + 1.0]);
pocket = pocket.fillet(width / 2.0 - 1.0, pocket.edges("|Z"));
let slope_cut = polygon([[-length, -width / 2.0 - 1.0, -depth - flange_t + wall], [-length, width / 2.0 + 1.0, -flange_t + 1.0], [-length, width / 2.0 + 1.0, -depth - flange_t + wall]]).to_face().extrude([2.0 * length, 0, 0]);
pocket = pocket - slope_cut;
pull = pull - pocket;
for s in [-1.0, 1.0] {
    let x = s * (length / 2.0 + flange / 2.0 + 0.5);
    pull = pull - cylinder([x, 0, -flange_t - 1.0], "Z", 1.8, flange_t + 2.0) - cone(1.8, 3.6, 1.9).translate([x, 0, -1.8]);
}
pull
