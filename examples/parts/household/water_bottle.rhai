// 500 ml water bottle: 65 mm body, 205 mm tall, shoulder taper to a 28 mm PCO neck with a thread bead, 1 mm walls
let body_d = 65.0; // [50.0, 90.0] Body diameter (mm)
let height = 205.0; // [150.0, 300.0] Height (mm)
let neck_d = 25.0; // [20.0, 40.0] Neck diameter (mm)
let wall = 1.0; // [0.5, 3.0] Wall thickness (mm)
let r = body_d / 2.0;
let profile = sketch("XZ").move_to(0, 0).hline_to(r - 4.0).arc_to(r - 1.2, 1.2, r, 4.0).vline_to(height * 0.62)
    .arc_to(r * 0.8, height * 0.78, neck_d / 2.0 + 0.5, height - 22.0).vline_to(height).hline_to(0).close();
let bottle = profile.to_face().revolve("Z", 360).shell(-wall, ">Z");
let bead = torus(neck_d / 2.0 + 0.5, 1.0).translate([0, 0, height - 10.0]);
let ring = cylinder([0, 0, height - 20.0], "Z", neck_d / 2.0 + 3.5, 1.5);
fuse_all([bottle, bead, ring])
