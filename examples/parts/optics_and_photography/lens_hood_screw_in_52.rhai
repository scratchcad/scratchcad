// 52 mm screw-in metal lens hood for a 50 mm standard lens: M52 x 0.75 male thread 3.5 mm long (shown as a band), 27 mm long flaring to 62 mm, 1.2 mm wall, M52 female filter thread at the base, knurled grip ring
let thread_size = 52.0; // [37.0, 82.0] Filter thread size (mm)
let length = 27.0; // [12.0, 60.0] Hood length (mm)
let flare = 5.0; // [0.0, 15.0] Radial flare at the front (mm)
let wall = 1.2; // [0.8, 2.5] Wall thickness (mm)
let r = thread_size / 2.0;
let base = cylinder([0, 0, -3.5], "Z", r - 0.05, 3.6).chamfer(0.3, "%CIRCLE and <Z");
let grip = cylinder(r + 1.5, 4.0);
for i in 0..40 {
    grip -= cylinder([r + 1.6, 0, -1.0], "Z", 0.35, 6.0).rotate_z(i.to_float() * 9.0);
}
let shell = polygon("XZ", [[r - 1.0, 3.9], [r - 1.0 + wall, 3.9], [r - 1.0 + wall + flare, length], [r - 1.0 + flare, length]]).to_face().revolve("Z", 360);
let hood = fuse_all([base, grip, shell]);
hood -= cylinder([0, 0, -5.0], "Z", r - 1.6, 10.0);
hood -= cylinder([0, 0, 0.5], "Z", r - 0.4, 3.0);
hood
