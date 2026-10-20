// Snowboard binding mounting disc, 4x4 insert pattern: 98 mm disc 6 mm thick, two 6.5 mm slots 50 mm long on 40 mm centres with 12 mm counterbores 3 mm deep, 60 serration teeth on a 10 degree bevelled rim
let diameter = 98.0; // [80.0, 120.0] Disc diameter (mm)
let thickness = 6.0; // [4.0, 10.0] Disc thickness (mm)
let hole_spacing = 40.0; // [30.0, 50.0] Insert spacing (mm)
let slot_length = 50.0; // [40.0, 64.0] Slot length (mm)
let teeth = 60; // [24, 90] Number of serration teeth
const slot_w = 6.5;
const cb_w = 12.0;
const cb_depth = 3.0;
let r = diameter / 2.0;
const bevel_w = 12.0;
let prof = [[0.0, 0.0], [r, 0.0], [r, thickness - bevel_w * (10.0 * PI() / 180.0).tan()], [r - bevel_w, thickness], [0.0, thickness]];
let disc = polygon("XZ", prof).to_face().revolve("Z", 360);
let sl = min(slot_length, diameter - 30.0);
let hs = hole_spacing / 2.0;
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(box_centered(slot_w, sl - slot_w, thickness + 2.0).translate([s * hs, 0, thickness / 2.0]) + cylinder([s * hs, -(sl - slot_w) / 2.0, -1.0], "Z", slot_w / 2.0, thickness + 2.0) + cylinder([s * hs, (sl - slot_w) / 2.0, -1.0], "Z", slot_w / 2.0, thickness + 2.0));
    cuts.push(box_centered(cb_w, sl - cb_w + 6.0, cb_depth + 1.0).translate([s * hs, 0, thickness - cb_depth + (cb_depth + 1.0) / 2.0]).fillet(cb_w / 2.0 - 0.01, "|Z"));
}
disc = disc - fuse_all(cuts);
let serr = [];
for i in 0..teeth {
    serr.push(box_centered(1.6, bevel_w + 2.0, 2.0).rotate_y(45.0).translate([0, r - bevel_w / 2.0, thickness]).rotate_z(i.to_float() * 360.0 / teeth.to_float()));
}
disc - compound(serr)
