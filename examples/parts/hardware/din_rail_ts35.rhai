// TS35 x 7.5 DIN rail, 100 mm long, 1 mm steel, with 5.2 x 15 mm slots at 25 mm pitch
let length = 100.0; // [25.0, 500.0] Length (mm)
let slot_pitch = 25.0; // [15.0, 50.0] Slot pitch (mm)
let t = 1.0;
let profile = polygon("YZ", [[-17.5, 7.5], [-12.5, 7.5], [-12.5, 0.0], [12.5, 0.0], [12.5, 7.5], [17.5, 7.5], [17.5, 7.5 - t], [12.5 + t, 7.5 - t], [12.5 + t, -t], [-12.5 - t, -t], [-12.5 - t, 7.5 - t], [-17.5, 7.5 - t]]);
let rail = profile.to_face().extrude([length, 0, 0]);
let n = (length / slot_pitch).floor().to_int();
let slots = [];
for i in 0..n {
    let x = slot_pitch / 2.0 + i.to_float() * slot_pitch;
    slots.push((box_centered(15.0 - 5.2, 5.2, 4.0) + cylinder([-(15.0 - 5.2) / 2.0, 0, -2], "Z", 2.6, 4.0) + cylinder([(15.0 - 5.2) / 2.0, 0, -2], "Z", 2.6, 4.0)).translate([x, 0, 0]));
}
rail - fuse_all(slots)
