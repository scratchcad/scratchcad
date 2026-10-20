// Coffee mug, 300 ml: 82 mm OD, 95 mm tall, 4 mm wall, 6 mm base with a foot ring, D-shaped handle swept from a 14 x 9 mm rounded section
let outer_diameter = 82.0; // [60.0, 110.0] Outside diameter (mm)
let height = 95.0; // [60.0, 140.0] Height (mm)
let wall = 4.0; // [3.7, 6.0] Wall thickness (mm)
let base = 6.0; // [4.0, 10.0] Base thickness (mm)
let handle_reach = 32.0; // [20.0, 50.0] Handle reach from the wall (mm)
let ro = outer_diameter / 2.0;
let ri = ro - wall;
let capacity = PI() * ri * ri * (height - base - 10.0) / 1000.0;
print(`capacity to 10 mm below the rim: ${capacity} ml`);
let mug = cylinder(ro, height).fillet(3.0, "%CIRCLE and <Z");
mug -= cylinder([0, 0, base], "Z", ri, height);
mug -= cylinder([0, 0, -1.0], "Z", ro - 8.0, 1.8);
mug = mug.fillet(1.8, mug.edges("%CIRCLE").filter(|e| e.center().z > height - 0.1));
// handle: a rounded section swept along a D-shaped path on -X, its ends buried in the wall
let x0 = -ro + 2.0;
let path = spline([[x0, 0, height - 18.0], [x0 - handle_reach * 0.7, 0, height - 16.0], [x0 - handle_reach, 0, height * 0.55], [x0 - handle_reach * 0.7, 0, 18.0], [x0, 0, 20.0]]);
let start = path.start_point();
let tan = path.tangent_at(0.0);
let section = face(rect(plane(start, tan, [0, 1, 0]), 2.0, 7.0).offset(3.5));
let handle = section.sweep(path);
mug + handle - cylinder([0, 0, base], "Z", ri, height)
