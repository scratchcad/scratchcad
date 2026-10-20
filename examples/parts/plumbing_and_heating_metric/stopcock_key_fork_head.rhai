// Long-reach stopcock key head: 30 mm tube head, 10 mm cross slot 20 mm deep that drops over a crutch handle, 18 mm hub pocket, 16.2 mm socket 30 mm deep for a 16 mm extension rod, 5 mm cross pin hole
let head_d = 30.0; // [24.0, 40.0] Head diameter (mm)
let slot_w = 10.0; // [6.0, 14.0] Crutch slot width (mm)
let slot_depth = 20.0; // [10.0, 30.0] Crutch slot depth (mm)
let hub = 18.0; // [12.0, 24.0] Hub pocket diameter (mm)
let rod = 16.0; // [10.0, 20.0] Extension rod diameter (mm)
let socket_depth = 30.0; // [15.0, 45.0] Rod socket depth (mm)
let r = max(head_d / 2.0, max(hub, rod) / 2.0 + 3.0);
let length = socket_depth + 6.0 + slot_depth;
let body = cylinder(r, length);
let body = body.chamfer(1.0, body.edges());
let top = length - slot_depth;
let slot = box_centered(2.0 * r + 2.0, slot_w, slot_depth * 2.0).translate([0, 0, length]);
let pocket = cylinder([0, 0, top], "Z", min(hub / 2.0, r - 2.0), slot_depth + 1.0);
body - slot - pocket - cylinder([0, 0, -1], "Z", rod / 2.0 + 0.2, socket_depth + 1.0) - cylinder([0, -r - 1.0, socket_depth * 0.5], "Y", 2.5, 2.0 * r + 2.0)
