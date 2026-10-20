// Jack stand saddle pad: 80 x 55 x 25 mm top block with a 12 mm x 16 mm pinch-weld slot, 40 mm wide tongue 18 mm deep to sit in a 3 t stand's U-saddle, grip grooves
let length = 80.0; // [60.0, 110.0] Pad length (mm)
let width = 55.0; // [45.0, 70.0] Pad width (mm)
let top_h = 25.0; // [18.0, 35.0] Top block height (mm)
let saddle_w = 40.0; // [30.0, 50.0] Saddle slot width (mm)
let slot_w = 12.0; // [8.0, 16.0] Pinch-weld slot width (mm)
let slot_d = 16.0; // [10.0, 20.0] Pinch-weld slot depth (mm)

const tongue_h = 18.0;
const grooves = 5;
let block = box_centered(length, width, top_h).translate([0, 0, tongue_h + top_h / 2.0]);
block = block.fillet(4.0, block.edges("|Z"));
block = block.fillet(2.0, block.edges(">Z"));
let tongue = box_centered(saddle_w - 1.0, width, tongue_h + 1.0).translate([0, 0, (tongue_h + 1.0) / 2.0]);
tongue = tongue.chamfer(3.0, tongue.edges("<Z and |Y"));
let pad = block + tongue;
let sd = min(slot_d, top_h - 5.0);
pad = pad - box_from_corners([-slot_w / 2.0, -width, tongue_h + top_h - sd], [slot_w / 2.0, width, tongue_h + top_h + 1.0]);
let cuts = [];
for i in 0..grooves {
    let y = (i - (grooves - 1) / 2.0) * width / (grooves + 1);
    cuts.push(box_centered(length + 2.0, 2.0, 3.0).translate([0, y, tongue_h + top_h]));
}
pad - compound(cuts)
