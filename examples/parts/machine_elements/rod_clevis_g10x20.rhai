// Rod end clevis DIN 71752 G 10x20: M10 female thread, 10 mm pin bore, 10 mm slot 20 mm deep, 20 mm square fork, 40 mm long, 16 mm hub
let pin_bore = 10.0; // [4.0, 20.0] Pin bore (mm)
let slot_width = 10.0; // [4.0, 20.0] Slot width (mm)
let slot_depth = 20.0; // [8.0, 40.0] Slot depth (mm)
let fork_width = 20.0; // [8.0, 40.0] Fork width (mm)
let overall_length = 40.0; // [16.0, 80.0] Overall length (mm)
let thread_diameter = 10.0; // [4.0, 20.0] Thread size (mm)
const hub_length = 12.0;
let half = fork_width / 2.0;
let sw = min(slot_width, fork_width - 4.0);
let ztop = overall_length;
let zpin = ztop - half;
let fork = box_from_corners([-half, -half, hub_length - 0.5], [half, half, zpin]) + cylinder([0, -half, zpin], "Y", half, fork_width);
let hub = cylinder([0, 0, 0], "Z", half * 0.8, hub_length);
let body = fuse_all([fork, hub]);
body = body - box_from_corners([-half - 1.0, -sw / 2.0, ztop - slot_depth], [half + 1.0, sw / 2.0, ztop + 1.0]);
body = body - cylinder([0, -half - 1.0, zpin], "Y", pin_bore / 2.0, fork_width + 2.0);
let tap = thread_diameter * 0.85;
body - cylinder([0, 0, -1], "Z", tap / 2.0, ztop - slot_depth + 0.5) - cone(tap / 2.0 + 0.8, tap / 2.0, 0.8).translate([0, 0, -0.01])
