// EN 60715 TS35 x 7.5 top-hat DIN rail, 1 mm steel, 200 mm long, 5.3 x 15 mm mounting slots on 25 mm pitch
let length = 200.0; // [50.0, 1000.0] Rail length (mm)
let slot_pitch = 25.0; // [15.0, 50.0] Slot pitch (mm)
let slot_len = 15.0; // [8.0, 20.0] Slot length (mm)
const t = 1.0;
const slot_w = 5.3;
let pts = [[-17.5, 7.5], [-12.5, 7.5], [-12.5, t], [12.5, t], [12.5, 7.5], [17.5, 7.5],
           [17.5, 7.5 - t], [13.5, 7.5 - t], [13.5, 0], [-13.5, 0], [-13.5, 7.5 - t], [-17.5, 7.5 - t]];
let rail = polygon("YZ", pts).to_face().extrude([length, 0, 0]);
let sl = min(slot_len, slot_pitch - 4.0);
let n = ((length - 10.0) / slot_pitch).floor().to_int();
let x0 = (length - (n - 1).to_float() * slot_pitch) / 2.0;
let slots = [];
for i in 0..n {
    let x = x0 + i.to_float() * slot_pitch;
    slots.push(box_centered(sl - slot_w, slot_w, 4.0).translate([x, 0, 0])
        + cylinder([x - (sl - slot_w) / 2.0, 0, -2], "Z", slot_w / 2.0, 4.0)
        + cylinder([x + (sl - slot_w) / 2.0, 0, -2], "Z", slot_w / 2.0, 4.0));
}
rail - compound(slots)
