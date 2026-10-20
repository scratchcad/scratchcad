// Edge dowel jig for 8 mm dowels: 80 x 30 x 20 mm body, 8 mm fence 30 mm deep, 2 bushing bosses 14 mm at 32 mm pitch, holes centred 9.5 mm from the fence for 19 mm stock
let pitch = 32.0; // [20.0, 64.0] Hole pitch (mm)
let dowel_d = 8.0; // [6.0, 12.0] Dowel diameter (mm)
let offset = 9.5; // [6.0, 20.0] Hole centre from the fence (mm)
let fence_depth = 30.0; // [20.0, 45.0] Fence depth (mm)
let length = 80.0; // [60.0, 120.0] Jig length (mm)
let depth = offset + dowel_d / 2.0 + 12.0;
let body = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, 20.0]);
let fence = box_from_corners([-length / 2.0, -8.0, -fence_depth], [length / 2.0, 0.01, 20.0]);
let bosses = [];
let holes = [];
for s in [-0.5, 0.5] {
    bosses.push(cylinder([s * pitch, offset, 19.99], "Z", dowel_d / 2.0 + 3.0, 10.0));
    holes.push(cylinder([s * pitch, offset, -1], "Z", dowel_d / 2.0 + 0.05, 32.0));
}
let mark = polygon([[-1.5, depth + 0.01, 21.0], [1.5, depth + 0.01, 21.0], [0, depth - 2.0, 21.0]]).to_face().extrude([0, 0, -22.0]);
let slot = box_from_corners([-length / 2.0 + 6.0, -9.0, -fence_depth + 6.0], [-length / 2.0 + 14.0, 1.0, -6.0]);
let p = body + fence + compound(bosses) - compound(holes) - mark;
p - slot - slot.mirror("YZ")
