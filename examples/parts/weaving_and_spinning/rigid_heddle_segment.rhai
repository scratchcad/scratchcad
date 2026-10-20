// Rigid heddle reed segment: 100 mm wide, 12 dent (12 slots/hole pairs per 25.4 mm), 80 mm tall, 3 mm thick
let width = 100.0; // [60.0, 200.0] Segment width (mm)
let dent = 12.0; // [7.5, 15.0] Dent size (slots per inch)
let height = 80.0; // [60.0, 120.0] Height (mm)
let t = 3.0; // [2.0, 4.0] Thickness (mm)
let pitch = 25.4 / dent;
let frame = box_from_corners([0, 0, 0], [width, t, height]);
let cuts = [];
let n = (width / pitch).floor().to_int() - 1;
for i in 0..n {
    let x = (i.to_float() + 1.0) * pitch;
    if i % 2 == 0 { cuts.push(box_from_corners([x - pitch * 0.3, -1, 12.0], [x + pitch * 0.3, t + 1.0, height - 12.0])); }
    else { cuts.push(cylinder([x, -1, height / 2.0], "Y", pitch * 0.3, t + 2.0)); }
}
frame - compound(cuts)
