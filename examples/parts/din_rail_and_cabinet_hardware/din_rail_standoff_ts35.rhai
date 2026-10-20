// Standoff that raises a TS35 rail 15 mm off the mounting plate: 60 x 20 x 3 mm base with two 5.5 mm slotted holes on 45 mm, hollow 20 x 35 mm pedestal with 2.5 mm walls and a 4.2 mm tapped hole in its 4 mm top for the rail screw
let rise = 15.0; // [8.0, 40.0] Rail height above the plate (mm)
let base_len = 60.0; // [50.0, 90.0] Base length (mm)
const base_w = 20.0;
const base_t = 3.0;
const wall = 2.5;
const top_t = 4.0;
let base = box_centered(base_len, base_w, base_t).translate([0, 0, base_t / 2.0]);
let base = base.fillet(3.0, base.edges("|Z"));
let ped = box_centered(35.0, base_w, rise).translate([0, 0, rise / 2.0]);
let hollow = box_centered(35.0 - 2.0 * wall, base_w + 2.0, rise - top_t + 1.0).translate([0, 0, (rise - top_t + 1.0) / 2.0 - 1.0]);
let tap = cylinder([0, 0, rise - top_t - 1.0], "Z", 2.1, top_t + 2.0);
let slots = [];
for sx in [-1.0, 1.0] {
    let x = sx * (base_len / 2.0 - 6.5);
    slots.push(box_centered(4.0, 5.5, base_t + 2.0).translate([x, 0, base_t / 2.0])
        + cylinder([x - 2.0, 0, -1.0], "Z", 2.75, base_t + 2.0) + cylinder([x + 2.0, 0, -1.0], "Z", 2.75, base_t + 2.0));
}
base + ped - hollow - tap - fuse_all(slots)
