// Hooded vent louvre plate for a cabinet side wall: 150 x 100 x 2 mm plate with 4 mm rounded corners and four 4.5 mm screw holes, five 90 x 8 mm slots on 16 mm pitch each under a closed 1.5 mm hood that opens downwards
let length = 150.0; // [110.0, 250.0] Plate length (mm)
let height = 100.0; // [70.0, 160.0] Plate height (mm)
let louvres = 5; // [2, 9] Number of louvres
let hood_depth = 6.0; // [3.0, 10.0] Hood projection (mm)
const t = 2.0;
const hood_t = 1.5;
const slot_h = 8.0;
const pitch = 16.0;
let slot_len = length - 60.0;
let plate = box_centered(length, t, height).translate([0, t / 2.0, 0]);
let plate = plate.fillet(4.0, plate.edges("|Y"));
let n = min(louvres, ((height - 30.0) / pitch).to_int() + 1);
let z0 = -(n.to_float() - 1.0) * pitch / 2.0;
let slots = [];
let hoods = [];
for i in 0..n {
    let z = z0 + i.to_float() * pitch;
    slots.push(box_centered(slot_len, t + 2.0, slot_h).translate([0, t / 2.0, z]));
    // wedge hood: closed top and ends, open underneath
    let outer = face(polygon([[0, 0, z - slot_h / 2.0], [0, -hood_depth, z - slot_h / 2.0], [0, 0, z + slot_h / 2.0 + hood_t]])).extrude([slot_len + 2.0 * hood_t, 0, 0]).translate([-slot_len / 2.0 - hood_t, 0, 0]);
    let k = (slot_h + hood_t) / hood_depth;
    let inner = face(polygon([[0, 0.5, z - slot_h / 2.0 - 0.5], [0, -hood_depth + hood_t, z - slot_h / 2.0 - 0.5], [0, 0.5, z + slot_h / 2.0]])).extrude([slot_len, 0, 0]).translate([-slot_len / 2.0, 0, 0]);
    hoods.push(outer - inner);
}
let holes = [];
for sx in [-1.0, 1.0] {
    for sz in [-1.0, 1.0] {
        holes.push(cylinder([sx * (length / 2.0 - 10.0), -1.0, sz * (height / 2.0 - 10.0)], "Y", 2.25, t + 2.0));
    }
}
plate - fuse_all(slots) + fuse_all(hoods) - fuse_all(holes)
