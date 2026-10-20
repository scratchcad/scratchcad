// PVC condensate P-trap for 3/4 in pipe (26.7 mm OD, 2.9 mm wall): 60 mm seal depth, U bend radius 30 mm, inlet riser and horizontal outlet with socket hubs, cleanout tee on top
let pipe_od = 26.7; // [16.0, 42.0] Pipe outside diameter (mm)
let wall = 2.9; // [1.5, 4.0] Wall thickness (mm)
let seal = 60.0; // [30.0, 100.0] Trap seal depth (mm)
let bend_r = 30.0; // [20.0, 60.0] U-bend centreline radius (mm)
let ro = pipe_od / 2.0;
let ri = ro - min(wall, ro - 2.0);
let br = max(bend_r, ro + 3.0);
let up = seal + 40.0;
fn pipe_run(r, br, up, ext) {
    let bend = torus(br, r).rotate_x(90.0) & box_from_corners([-br - r - 1.0, -r - 1.0, -br - r - 1.0], [br + r + 1.0, r + 1.0, 0]);
    let left = cylinder([-br, 0, 0], "Z", r, up + ext);
    let h = up * 0.7;
    let right = cylinder([br, 0, 0], "Z", r, h);
    let e = br * 0.8;
    let elbow = (torus(e, r).rotate_x(90.0) & box_from_corners([-e - r - 1.0, -r - 1.0, 0], [0, r + 1.0, e + r + 1.0])).translate([br + e, 0, h]);
    let out = cylinder([br + e, 0, h + e], "X", r, 50.0 + ext);
    fuse_all([bend, left, right, elbow, out])
}
let outer = pipe_run(ro, br, up, 0.0);
let inner = pipe_run(ri, br, up, 1.0);
let hub = cylinder([-br, 0, up - 25.0], "Z", ro + 3.0, 25.0);
(outer + hub) - inner - cylinder([-br, 0, up - 20.0], "Z", ro + 0.1, 21.0)
