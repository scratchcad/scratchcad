// Two-part snap-fit case for a Raspberry Pi 4 Model B (base and lid, side by side)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let clearance = 1.0; // [0.5, 2.0] Clearance around the board (mm)
let inside_h = 22.0; // [18.0, 30.0] Inside height (mm)
let lid_h = 6.0; // [4.0, 10.0] Lid height (mm)
let vent_slots = 8; // [0, 14] Lid vent slots
let bw = 85.0 + 2.0 * clearance; let bh = 56.0 + 2.0 * clearance;
let ow = bw + 2.0 * wall; let oh = bh + 2.0 * wall;
let base_h = inside_h - lid_h + wall;
const standoff_h = 3.0;
let board_z = wall + standoff_h;          // PCB underside
let base = box(ow, oh, base_h).fillet(3.0, "|Z") - box_from_corners([wall, wall, wall], [ow - wall, oh - wall, base_h + 1.0]);
let x0 = wall + clearance; let y0 = wall + clearance;
for x in [3.5, 61.5] { for y in [3.5, 52.5] {
    base = base + (cylinder([x0 + x, y0 + y, wall - 0.1], "Z", 2.75, standoff_h + 0.1) - cylinder([x0 + x, y0 + y, wall], "Z", 1.1, standoff_h + 1.0));
} }
// long side (y = 0): USB-C at x 3.5+7.7, micro-HDMI at 26 and 39.5, audio at 54 (from the board's corner)
let port_z = board_z + 1.4;
let cuts = [];
for p in [[11.2, 10.0, 4.0], [26.0, 8.0, 4.0], [39.5, 8.0, 4.0], [54.0, 7.0, 7.0]] {
    cuts.push(box_centered(p[1], wall * 4.0, p[2]).translate([x0 + p[0], wall / 2.0, port_z + p[2] / 2.0]));
}
// short side (x = max): 2x USB stacks and Ethernet
for p in [[9.0, 13.5, 16.0], [27.0, 13.5, 16.0], [45.75, 16.0, 13.5]] {
    cuts.push(box_centered(wall * 4.0, p[1], p[2]).translate([ow - wall / 2.0, y0 + p[0], port_z + p[2] / 2.0]));
}
base = base - fuse_all(cuts);
// the lid: a shallow tray with a lip that fits inside the base
const lip = 3.0;
let lid = box(ow, oh, lid_h).fillet(3.0, "|Z") - box_from_corners([wall, wall, wall], [ow - wall, oh - wall, lid_h + 1.0]);
lid = lid + (box_from_corners([wall + 0.2, wall + 0.2, wall - 0.1], [ow - wall - 0.2, oh - wall - 0.2, lid_h + lip])
    - box_from_corners([wall + 1.4, wall + 1.4, lid_h - 1.0], [ow - wall - 1.4, oh - wall - 1.4, lid_h + lip + 1.0]));
let slots = [];
for i in 0..vent_slots {
    let x = ow / 2.0 + (i.to_float() - (vent_slots - 1).to_float() / 2.0) * 6.0;
    slots.push(box_centered(2.5, oh * 0.5, wall * 3.0).translate([x, oh / 2.0, 0]));
}
if vent_slots > 0 { lid = lid - fuse_all(slots); }
[base, lid.translate([0, oh + 10.0, 0])]
