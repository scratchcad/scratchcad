// Portable air conditioner window nozzle for a 150 mm hose: 152 mm ID cuff 40 mm deep with 2 bayonet lugs, 120 mm transition to a 260 x 45 mm flat slot outlet with a 25 mm straight lip, 2 mm wall
let hose_d = 152.0; // [100.0, 160.0] Hose cuff inside diameter (mm)
let slot_w = 260.0; // [180.0, 400.0] Slot width (mm)
let slot_h = 45.0; // [25.0, 80.0] Slot height (mm)
let transition = 120.0; // [80.0, 200.0] Transition length (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
const cuff = 40.0;
const lip = 25.0;
let rc = hose_d / 2.0;
let z1 = cuff;
let z2 = cuff + transition;
let outer = fuse_all([
    cylinder(rc + wall, z1),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), rc + wall), rect(plane([0, 0, z2], [0, 0, 1]), slot_w + 2.0 * wall, slot_h + 2.0 * wall)], true),
    box_centered(slot_w + 2.0 * wall, slot_h + 2.0 * wall, lip).translate([0, 0, z2 + lip / 2.0])]);
let hollow = fuse_all([
    cylinder([0, 0, -1], "Z", rc, z1 + 1.0),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), rc - 2.0), rect(plane([0, 0, z2], [0, 0, 1]), slot_w, slot_h)], true),
    box_centered(slot_w, slot_h, lip + 2.0).translate([0, 0, z2 + lip / 2.0 + 1.0])]);
let nozzle = outer - hollow;
let lugs = [];
for k in 0..2 {
    lugs.push(box_from_corners([rc - 2.5, -6.0, 8.0], [rc + 0.5, 6.0, 12.0]).rotate_z(90.0 + k.to_float() * 180.0));
}
nozzle + fuse_all(lugs)
