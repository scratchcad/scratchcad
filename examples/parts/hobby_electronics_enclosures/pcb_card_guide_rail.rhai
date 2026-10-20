// PCB card guide rail for 1.6 mm boards: 100 mm long, 8 x 8 mm section, 1.9 mm slot 3 mm deep along the top, 45 degree flared entry 6 mm, 2 x M3 countersunk holes 70 mm apart
let length = 100.0; // [40.0, 200.0] Rail length (mm)
let width = 8.0; // [6.0, 12.0] Rail width (mm)
let height = 8.0; // [6.0, 15.0] Rail height (mm)
let slot_w = 1.9; // [1.0, 3.0] Card slot width (mm)
let slot_d = 3.0; // [2.0, 5.0] Card slot depth (mm)
let hole_pitch = 70.0; // [20.0, 180.0] Mounting hole spacing (mm)
let rail = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let rail = rail.chamfer(0.6, rail.edges("|X and >Z"));
let sd = min(slot_d, height - 3.5);
let slot = box_from_corners([-1, -slot_w / 2.0, height - sd], [length + 1.0, slot_w / 2.0, height + 1.0]);
let flare = polygon([[-1.0, -slot_w / 2.0 - 2.33, height + 1.0], [6.0, -slot_w / 2.0, height + 1.0], [6.0, slot_w / 2.0, height + 1.0], [-1.0, slot_w / 2.0 + 2.33, height + 1.0]]).to_face().extrude([0, 0, -sd - 1.0]);
let hp = min(hole_pitch, length - 16.0);
let holes = [];
for x in [length / 2.0 - hp / 2.0, length / 2.0 + hp / 2.0] {
    let hole_s = cylinder([x, 0, -1], "Z", 1.6, height + 2.0) + cone(1.6, 3.2, 1.6).translate([x, 0, height - sd - 1.6]) + cylinder([x, 0, height - sd - 0.3], "Z", 3.2, sd + 1.3);
    holes.push(hole_s);
}
rail - fuse_all([slot, flare]) - compound(holes)
