// Mounting ring for 125 mm ceiling valves: 124.5 mm ID sleeve 30 mm tall with 2 mm wall, 3 L-shaped bayonet slots 5 mm wide, 150 mm flange 2.5 mm with 3 x 4.5 mm countersunk screw holes
let valve_d = 124.5; // [80.0, 200.0] Ring inside diameter (mm)
let height = 30.0; // [20.0, 45.0] Sleeve height (mm)
let flange_w = 10.75; // [10.0, 25.0] Flange width (mm)
let slot_turn = 15.0; // [8.0, 25.0] Bayonet slot turn length (mm)
const wall = 2.0;
const flange_t = 2.5;
const slot_w = 5.0;
let ri = valve_d / 2.0;
let ro = ri + wall;
let rf = ro + flange_w;
let ring = cylinder(ro, height) + cylinder(rf, flange_t);
ring = ring - cylinder([0, 0, -1], "Z", ri, height + 2.0);
let cuts = [];
for k in 0..3 {
    let a = k.to_float() * 120.0;
    let down = box_from_corners([ri - 4.0, -slot_w / 2.0, height - 12.0], [ro + 1.0, slot_w / 2.0, height + 1.0]);
    // the turn follows the ring: an annular sector from the slot round by slot_turn
    let a0 = slot_w / 2.0 / ri;
    let a1 = slot_turn / ri;
    let sector = polygon([[0, 0, height - 13.0], [2.0 * ro * a0.cos(), -2.0 * ro * a0.sin(), height - 13.0], [2.0 * ro * a1.cos(), 2.0 * ro * a1.sin(), height - 13.0]]).to_face().extrude([0, 0, slot_w + 1.0]);
    let band = cylinder([0, 0, height - 12.0], "Z", ro + 1.0, slot_w) - cylinder([0, 0, height - 13.0], "Z", ri - 1.0, slot_w + 2.0);
    let turn = band & sector;
    cuts.push(fuse_all([down, turn]).rotate_z(a));
    let hr = ro + flange_w * 0.5;
    let b = (a + 60.0) * PI() / 180.0;
    cuts.push(cylinder([hr * b.cos(), hr * b.sin(), -1], "Z", 2.25, flange_t + 2.0) + cone(2.25, 4.2, 1.95).translate([hr * b.cos(), hr * b.sin(), flange_t - 1.94]));
}
ring - fuse_all(cuts)
