// Round wall vent grille for a 150 mm duct: 190 mm face plate 4 mm with a chamfered rim, concentric 5 mm air slots split by 4 ribs, 148 mm OD spigot 40 mm long with 2 mm wall
let spigot_d = 148.0; // [100.0, 200.0] Spigot outside diameter (mm)
let rim = 21.0; // [10.0, 40.0] Face rim beyond the spigot (mm)
let face_t = 4.0; // [3.0, 8.0] Face plate thickness (mm)
let spigot_l = 40.0; // [20.0, 80.0] Spigot length (mm)
let wall = 2.0; // [1.5, 3.5] Spigot wall (mm)
const slot_w = 5.0;
const pitch = 9.0;
const rib_w = 6.0;
let rs = spigot_d / 2.0;
let rf = rs + rim;
let face = polygon([[0, 0, 0], [rf, 0, 0], [rf, 0, 1.0], [rf - 3.0, 0, face_t], [0, 0, face_t]]).to_face().revolve("Z", 360);
let spigot = cylinder([0, 0, -spigot_l], "Z", rs, spigot_l) - cylinder([0, 0, -spigot_l - 1.0], "Z", rs - wall, spigot_l + 1.0);
// slot rings between a 12 mm hub and the spigot bore
let rings = [];
let ring_count = ((rs - wall - 2.0 - slot_w - 12.0) / pitch).floor().to_int() + 1;
for i in 0..ring_count {
    let r_in = 12.0 + i.to_float() * pitch;
    rings.push(cylinder([0, 0, -1], "Z", r_in + slot_w, face_t + 2.0) - cylinder([0, 0, -2], "Z", r_in, face_t + 4.0));
}
let ribs = fuse_all([box_centered(2.0 * rf, rib_w, face_t + 6.0), box_centered(rib_w, 2.0 * rf, face_t + 6.0)]);
let slots = compound(rings) - ribs;
face + spigot - slots
