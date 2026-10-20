// Pizza cutter: 100 mm stainless wheel 2 mm thick with a 30 deg double-bevel edge, 8 mm axle rivet in a 26 mm fork, 120 mm handle 28 mm diameter with a thumb guard
let wheel_diameter = 100.0; // [60.0, 140.0] Wheel diameter (mm)
let wheel_thickness = 2.0; // [1.0, 3.0] Wheel thickness (mm)
let bevel_width = 4.0; // [2.0, 8.0] Edge bevel width (mm)
let handle_length = 120.0; // [80.0, 160.0] Handle length (mm)
let handle_diameter = 28.0; // [20.0, 36.0] Handle diameter (mm)
let rw = wheel_diameter / 2.0;
let t = wheel_thickness;
// wheel in the XZ plane (axle along Y): a revolved section with a sharpened rim
const edge = 0.15;
let wheel = polygon("XY", [[4.2, -t / 2.0], [rw - bevel_width, -t / 2.0], [rw, -edge], [rw, edge], [rw - bevel_width, t / 2.0], [4.2, t / 2.0]]).to_face().revolve("Y", 360);
// fork: two cheeks either side of the wheel joined above it, carrying the axle rivet
let cheek = box_from_corners([-10.0, t / 2.0 + 0.5, -8.0], [10.0, t / 2.0 + 3.0, rw + 14.0]).fillet(4.0, "|Y");
let fork = cheek + cheek.mirror("XZ") + box_from_corners([-10.0, -t / 2.0 - 3.0, rw + 6.0], [10.0, t / 2.0 + 3.0, rw + 14.0]);
fork = fork + cylinder([0, -t / 2.0 - 4.0, 0], "Y", 4.0, t + 8.0);
// handle continuing up from the fork, with a thumb guard disc
let rh = handle_diameter / 2.0;
let z0 = rw + 13.0;
let handle = sketch("XZ").move_to(0, z0).hline_to(8.0).line_to(rh, z0 + 25.0).arc_to(rh + 1.0, z0 + handle_length * 0.6, rh - 2.0, z0 + handle_length - 6.0).arc_to(rh * 0.6, z0 + handle_length - 0.5, 0, z0 + handle_length).close().to_face().revolve("Z", 360);
let guard = cylinder([0, 0, z0 + 6.0], "Z", rh + 8.0, 3.0).fillet(1.2, "%CIRCLE");
compound([wheel, fuse_all([fork, handle, guard])])
