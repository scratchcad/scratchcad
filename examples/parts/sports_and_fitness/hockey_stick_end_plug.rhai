// Composite hockey stick end plug: 31 x 19 mm cap 8 mm thick with rounded corners and a domed top, 26 x 14 mm tapered insert 40 mm long with three grip ribs
let cap_w = 31.0; // [26.0, 36.0] Cap width (mm)
let cap_d = 19.0; // [16.0, 24.0] Cap depth (mm)
let cap_t = 8.0; // [5.0, 12.0] Cap thickness (mm)
let insert_w = 26.0; // [20.0, 32.0] Insert width (mm)
let insert_d = 14.0; // [10.0, 20.0] Insert depth (mm)
let insert_length = 40.0; // [20.0, 60.0] Insert length (mm)
let ribs = 3; // [0, 6] Number of grip ribs
let iw = min(insert_w, cap_w - 2.0);
let id = min(insert_d, cap_d - 2.0);
let cap = box_centered(cap_w, cap_d, cap_t).translate([0, 0, cap_t / 2.0]).fillet(min(5.0, cap_d / 2.0 - 1.0), "|Z").fillet(2.0, ">Z");
let tip = rect(plane([0, 0, -insert_length], [0, 0, 1]), iw - 3.0, id - 3.0);
let root = rect(plane([0, 0, 0.5], [0, 0, 1]), iw, id);
let insert = loft([tip, root], true);
let plug = cap + insert;
let rib_parts = [];
for i in 0..ribs {
    let z = -insert_length * (0.2 + 0.6 * i.to_float() / max(ribs - 1, 1).to_float());
    let f = 1.0 + z / insert_length * 0.12;
    rib_parts.push(box_centered(iw * f + 1.0, id * f + 1.0, 1.5).translate([0, 0, z]));
}
if ribs > 0 { plug = plug + compound(rib_parts); }
plug
