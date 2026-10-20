// Round soffit vent disc 70 mm: 85 mm face flange 2 mm, 70 mm push-in body 15 mm deep with 1.5 mm wall, 2 x 3.5 mm insect slots across the face, 4 springy retention fins
let body_d = 70.0; // [40.0, 100.0] Hole diameter (mm)
let flange_extra = 7.5; // [4.0, 15.0] Flange overlap each side (mm)
let depth = 15.0; // [10.0, 30.0] Body depth (mm)
let slot_w = 2.0; // [1.5, 3.0] Slot width (mm)
const wall = 1.5;
const flange_t = 2.0;
let rb = body_d / 2.0;
let rf = rb + flange_extra;
let flange = cylinder(rf, flange_t).chamfer(flange_t * 0.6, ">Z");
flange = flange.rotate_x(180.0).translate([0, 0, flange_t]);
let body = cylinder([0, 0, flange_t - 0.5], "Z", rb, depth + 0.5) - cylinder([0, 0, flange_t], "Z", rb - wall, depth + 1.0);
let vent = flange + body;
let slots = [];
let pitch = slot_w + 1.5;
let n = ((rb - wall - 2.0) / pitch).floor().to_int();
for i in 0..(2 * n + 1) {
    slots.push(box_centered(2.0 * rb, slot_w, flange_t * 4.0).translate([0, (i - n).to_float() * pitch, 0]));
}
let field = compound(slots) & cylinder([0, 0, -flange_t], "Z", rb - wall - 2.0, flange_t * 4.0);
vent = vent - field;
let fins = [];
for k in 0..4 {
    let fin = box_from_corners([rb - 0.5, -6.0, flange_t + 4.0], [rb + 2.0, 6.0, flange_t + 5.2]).rotate([rb, 0, flange_t + 4.0], "Y", -35.0);
    fins.push(fin.rotate_z(k.to_float() * 90.0 + 45.0));
}
vent + fuse_all(fins)
