// Mainboard cooling fan bracket for a 40 mm fan on 2020 extrusion: 44 x 44 x 3 mm fan plate with 4 x M3 holes on 32 mm and a 38 mm opening crossed by a 2 mm guard ring and 4 spokes, 20 x 44 mm foot 4 mm thick at 90 degrees with an M5 slot 10 mm long, 2 gussets
let fan = 40.0; // [30.0, 60.0] Fan size (mm)
let foot_l = 20.0; // [15.0, 40.0] Foot length (mm)
let slot_l = 10.0; // [0.0, 16.0] M5 slot length (mm)
const plate_t = 3.0;
const foot_t = 4.0;
let s = fan + 4.0;
let hp = fan * 0.8;
let plate = box_from_corners([-s / 2.0, 0, 0], [s / 2.0, plate_t, s]);
plate = plate.fillet(3.0, plate.edges("|Y and >Z"));
let ro = fan * 0.475;
plate = plate - cylinder([0, -1, s / 2.0], "Y", ro, plate_t + 2.0);
let guard = fuse_all([
    cylinder([0, 0, s / 2.0], "Y", ro * 0.55 + 1.0, plate_t) - cylinder([0, -1, s / 2.0], "Y", ro * 0.55 - 1.0, plate_t + 2.0),
    box_centered(2.0 * ro + 1.0, plate_t, 2.0).translate([0, plate_t / 2.0, s / 2.0]),
    box_centered(2.0, plate_t, 2.0 * ro + 1.0).translate([0, plate_t / 2.0, s / 2.0])]);
plate = plate + guard;
let holes = [];
for sx in [-1.0, 1.0] {
    for sz in [-1.0, 1.0] {
        holes.push(cylinder([sx * hp / 2.0, -1, s / 2.0 + sz * hp / 2.0], "Y", 1.6, plate_t + 2.0));
    }
}
plate = plate - compound(holes);
let foot = box_from_corners([-s / 2.0, -foot_l, 0], [s / 2.0, 0.5, foot_t]);
let gussets = [];
for sx in [-1.0, 1.0] {
    gussets.push(polygon([[sx * s / 2.0, -foot_l + 2.0, foot_t - 0.5], [sx * s / 2.0, 0.5, foot_t - 0.5], [sx * s / 2.0, 0.5, foot_t + foot_l * 0.8]]).to_face().extrude([-sx * 3.0, 0, 0]));
}
let bracket = fuse_all([plate, foot] + gussets);
let sl = min(slot_l, s - 20.0);
let x0 = -sl / 2.0;
let slot = if sl > 0.5 {
    fuse_all([cylinder([x0, -foot_l / 2.0, -1], "Z", 2.7, foot_t + 2.0), cylinder([x0 + sl, -foot_l / 2.0, -1], "Z", 2.7, foot_t + 2.0), box_from_corners([x0, -foot_l / 2.0 - 2.7, -1], [x0 + sl, -foot_l / 2.0 + 2.7, foot_t + 1.0])])
} else {
    cylinder([0, -foot_l / 2.0, -1], "Z", 2.7, foot_t + 2.0)
};
bracket - slot
