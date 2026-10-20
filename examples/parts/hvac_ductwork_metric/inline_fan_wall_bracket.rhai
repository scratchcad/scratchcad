// Inline duct fan wall bracket: 3 mm L bracket 40 mm wide, 120 mm wall leg with 2 x 8 x 20 mm slotted holes, 60 mm fan leg with 2 x M6 (6.5 mm) holes on 40 mm, triangular gusset
let width = 40.0; // [30.0, 60.0] Bracket width (mm)
let wall_leg = 120.0; // [80.0, 180.0] Wall leg length (mm)
let fan_leg = 60.0; // [40.0, 100.0] Fan leg length (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let hole_pitch = 40.0; // [25.0, 60.0] Fan hole spacing (mm)
const slot_l = 20.0;
let wall_plate = box_from_corners([0, -width / 2.0, 0], [t, width / 2.0, wall_leg]);
let fan_plate = box_from_corners([0, -width / 2.0, 0], [fan_leg, width / 2.0, t]);
let g = min(fan_leg, wall_leg) * 0.6;
let gusset = polygon([[t - 0.5, 0, t - 0.5], [g, 0, t - 0.5], [t - 0.5, 0, g]]).to_face().extrude([0, 3.0, 0]).translate([0, -1.5, 0]);
let bracket = fuse_all([wall_plate, fan_plate, gusset]);
let slots = [];
for z in [wall_leg * 0.55, wall_leg - 15.0] {
    slots.push(fuse_all([cylinder([-1, -width / 4.0 - 4.0, z], "X", 4.0, t + 2.0), cylinder([-1, -width / 4.0 - 4.0, z - slot_l + 8.0], "X", 4.0, t + 2.0), box_from_corners([-1, -width / 4.0 - 8.0, z - slot_l + 8.0], [t + 1.0, -width / 4.0, z])]));
}
let hp = min(hole_pitch, fan_leg - 16.0);
let holes = [];
for x in [fan_leg - 8.0, fan_leg - 8.0 - hp] {
    holes.push(cylinder([x, width / 4.0, -1], "Z", 3.25, t + 2.0));
}
bracket - fuse_all(slots) - compound(holes)
