// Stepped seed dibber: 150 mm hand dibber with a 25 mm cone tip marked by 1 mm depth grooves at 10, 20, 30, 40 and 50 mm, 30 mm grip with 12 flats and a 6 mm hanging hole
// # Tip
let tip_length = 60.0; // [40.0, 80.0] Tip length (mm)
let tip_d = 25.0; // [15.0, 35.0] Tip base diameter (mm)
let marks = 5; // [2, 7] Number of depth marks
// # Handle
let grip_d = 30.0; // [22.0, 40.0] Grip diameter (mm)
let grip_length = 90.0; // [60.0, 120.0] Grip length (mm)
const mark_pitch = 10.0;
let tip = sketch("XZ").move_to(0, 0).line_to(2.0, 0).line_to(tip_d / 2.0, tip_length).hline_to(0).close().to_face().revolve("Z", 360);
let grip = cylinder([0, 0, tip_length - 0.01], "Z", grip_d / 2.0, grip_length).chamfer(3.0, ">Z");
let body = tip + grip;
let gs = [];
for i in 1..=marks {
    let z = i.to_float() * mark_pitch;
    if z < tip_length - 3.0 {
        let rz = 2.0 + (tip_d / 2.0 - 2.0) * z / tip_length;
        gs.push(cylinder([0, 0, z - 0.5], "Z", rz + 1.0, 1.0) - cylinder([0, 0, z - 1.0], "Z", rz - 0.8, 2.0));
    }
}
let flats = [];
for i in 0..12 {
    flats.push(box_from_corners([grip_d / 2.0 - 1.0, -grip_d, tip_length + 8.0], [grip_d, grip_d, tip_length + grip_length - 12.0]).rotate_z(i.to_float() * 30.0));
}
let hang = cylinder([0, -grip_d, tip_length + grip_length - 10.0], "Y", 3.0, grip_d * 2.0);
body - fuse_all(gs) - fuse_all(flats) - hang
