// Ointment tube winding key: 8 mm shaft 55 mm long with a 2.4 mm slot 45 mm long through it for the crimped tube end, open at the tip, on a 34 x 14 x 6 mm wing handle with 5 mm rounded ends, 1 mm tip chamfer
let shaft_d = 8.0; // [6.0, 12.0] Shaft diameter (mm)
let shaft_len = 55.0; // [40.0, 80.0] Shaft length (mm)
let slot_w = 2.4; // [1.5, 3.5] Slot width (mm)
let slot_len = 45.0; // [30.0, 60.0] Slot length (mm)
let handle_w = 34.0; // [25.0, 50.0] Handle span (mm)
const handle_d = 14.0;
const handle_t = 6.0;
let sl = min(slot_len, shaft_len - 5.0);
let shaft = cylinder([0, 0, handle_t - 0.5], "Z", shaft_d / 2.0, shaft_len + 0.5);
let shaft = shaft.chamfer(1.0, shaft.edges(">Z"));
let handle = box_centered(handle_w, handle_d, handle_t).translate([0, 0, handle_t / 2.0]);
let handle = handle.fillet(5.0, handle.edges("|Z"));
let key = shaft + handle;
let top = handle_t + shaft_len;
key - box_from_corners([-slot_w / 2.0, -shaft_d, top - sl], [slot_w / 2.0, shaft_d, top + 1.0])
