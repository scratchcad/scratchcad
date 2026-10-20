// Syringe pump pusher block: 73 x 24 x 48 mm carriage riding on two 8 mm rods 50 mm apart (15.2 mm LM8UU bores 24 mm long), T8 leadscrew nut seat 10.5 mm bore with 4 x M3 holes on 16 mm, 2.5 mm slot near the top for the plunger flange
let rod_spacing = 50.0; // [36.0, 70.0] Rod spacing (mm)
let bearing_d = 15.2; // [10.2, 16.0] Linear bearing bore (mm)
let nut_bore = 10.5; // [8.5, 12.0] Leadscrew nut bore (mm)
let flange_slot = 2.5; // [1.5, 4.0] Plunger flange slot width (mm)
let height = 48.0; // [48.0, 70.0] Block height (mm)
const depth = 24.0;
const rod_z = 10.0;
let length = rod_spacing + bearing_d + 8.0;
let block = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, height]);
block = block.fillet(3.0, "|Y");
let cuts = [];
for sx in [-1.0, 1.0] {
    cuts.push(cylinder([sx * rod_spacing / 2.0, -1, rod_z + bearing_d / 2.0], "Y", bearing_d / 2.0, depth + 2.0));
}
let nut_z = rod_z + bearing_d / 2.0;
cuts.push(cylinder([0, -1, nut_z], "Y", nut_bore / 2.0, depth + 2.0));
for k in 0..4 {
    let a = (45.0 + k.to_float() * 90.0) * PI() / 180.0;
    cuts.push(cylinder([8.0 * a.cos(), -1, nut_z + 8.0 * a.sin()], "Y", 1.6, depth + 2.0));
}
// the plunger flange drops into a slot across the top, the plunger rod passes through a 12 mm notch
let top_z = height - 8.0;
cuts.push(box_from_corners([-length / 2.0 - 1.0, depth * 0.5 - flange_slot / 2.0, top_z - 12.0], [length / 2.0 + 1.0, depth * 0.5 + flange_slot / 2.0, height + 1.0]));
cuts.push(box_from_corners([-6.0, depth * 0.5, top_z - 6.0], [6.0, depth + 1.0, height + 1.0]));
block - fuse_all(cuts)
