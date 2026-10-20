// Golf divot repair tool: 30 mm wide, 4 mm thick body 32 mm long, two 28 mm prongs 4.5 mm wide tapering to points, 6 mm gap, 24.5 mm ball-marker recess 1 mm deep
let width = 30.0; // [24.0, 40.0] Body width (mm)
let body_length = 32.0; // [25.0, 45.0] Body length (mm)
let prong_length = 28.0; // [18.0, 40.0] Prong length (mm)
let prong_w = 4.5; // [3.0, 7.0] Prong width at the root (mm)
let gap = 6.0; // [3.0, 12.0] Gap between prongs (mm)
let thickness = 4.0; // [2.5, 6.0] Thickness (mm)
const marker_d = 24.5;
let w = max(width, marker_d + 3.0);
let body = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, body_length, thickness]).fillet(w / 2.0 - 0.5, "|Z and >Y");
let prongs = [];
for s in [-1.0, 1.0] {
    let x1 = s * gap / 2.0;
    let x2 = s * (gap / 2.0 + prong_w);
    let tip = s * (gap / 2.0 + prong_w * 0.4);
    let pts = if s > 0.0 { [[x1, 0.5], [tip, -prong_length], [x2, 0.5]] } else { [[x2, 0.5], [tip, -prong_length], [x1, 0.5]] };
    prongs.push(polygon(pts).to_face().extrude([0, 0, thickness]));
}
let tool = fuse_all([body] + prongs);
tool = tool - cylinder([0, body_length - marker_d / 2.0 - 1.5, thickness - 1.0], "Z", marker_d / 2.0, 2.0);
tool.chamfer(0.5, tool.edges("<Z").filter(|e| e.center().y > 0.6))
