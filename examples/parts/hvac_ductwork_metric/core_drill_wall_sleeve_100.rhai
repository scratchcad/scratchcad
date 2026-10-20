// Wall sleeve for a 107 mm core-drilled hole, 100 mm duct: 106 mm OD x 2.5 mm tube 250 mm long, 145 mm inner face flange 3 mm with 4 x 4.5 mm screw holes, outer end cut with a 5 mm drip lip
let core_d = 106.0; // [80.0, 170.0] Sleeve outside diameter (mm)
let length = 250.0; // [150.0, 500.0] Sleeve length (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let flange_w = 19.5; // [10.0, 35.0] Flange width (mm)
const flange_t = 3.0;
let ro = core_d / 2.0;
let rf = ro + flange_w;
let tube = cylinder([0, 0, 0], "X", ro, length);
let flange = cylinder([0, 0, 0], "X", rf, flange_t);
let drip = cylinder([length - 8.0, 0, 0], "X", ro + 5.0, 2.0) & box_from_corners([length - 9.0, -ro - 6.0, -ro - 6.0], [length - 5.0, ro + 6.0, 0]);
let sleeve = fuse_all([tube, flange, drip]) - cylinder([-1, 0, 0], "X", ro - wall, length + 2.0);
let holes = [];
for k in 0..4 {
    let a = (45.0 + k.to_float() * 90.0) * PI() / 180.0;
    let rh = ro + flange_w / 2.0;
    holes.push(cylinder([-1, rh * a.cos(), rh * a.sin()], "X", 2.25, flange_t + 2.0));
}
sleeve - compound(holes)
