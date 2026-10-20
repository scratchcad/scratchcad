// Tripod ball head ball: 36 mm polished sphere with a 16 mm neck 10 mm long to a 40 mm top platform 6 mm thick, 3/8-16 stud hole in the platform, flat on the underside
let ball_diameter = 36.0; // [20.0, 60.0] Ball diameter (mm)
let neck_diameter = 16.0; // [8.0, 30.0] Neck diameter (mm)
let neck_length = 10.0; // [4.0, 20.0] Neck length above the ball (mm)
let platform_diameter = 40.0; // [25.0, 70.0] Platform diameter (mm)
let platform_thickness = 6.0; // [3.0, 12.0] Platform thickness (mm)
let rb = ball_diameter / 2.0;
let rn = min(neck_diameter / 2.0, rb * 0.7);
// the neck leaves the ball where the sphere is rn from the axis
let z_neck = sqrt(rb * rb - rn * rn);
let ball = sphere(rb) & box_centered(3.0 * rb, 3.0 * rb, 2.0 * rb).translate([0, 0, 1.5]);
let neck = cylinder([0, 0, z_neck - 1.0], "Z", rn, neck_length + rb - z_neck + 1.0);
let z_top = rb + neck_length;
let platform = cylinder([0, 0, z_top], "Z", platform_diameter / 2.0, platform_thickness).chamfer(0.8, "%CIRCLE");
let part = fuse_all([ball, neck, platform]);
part = part.fillet(1.5, part.edges("%CIRCLE").filter(|e| (e.radius() - rn).abs() < 0.01 && e.center().z > z_top - 0.1));
part - cylinder([0, 0, z_top + platform_thickness - 10.0], "Z", 4.2, 11.0)
