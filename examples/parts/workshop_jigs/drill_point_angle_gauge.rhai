// Drill point angle gauge for 118 degree points: 100 x 40 x 1.5 mm plate, 59 degree end edge, 1 mm deep graduations every 5 mm along the top edge, 5 mm hanging hole
let length = 100.0; // [60.0, 150.0] Gauge length (mm)
let width = 40.0; // [25.0, 60.0] Gauge width (mm)
let t = 1.5; // [1.0, 3.0] Thickness (mm)
let lip_angle = 59.0; // [45.0, 70.0] Lip angle to the drill axis (degrees)
let run = width / (lip_angle * PI() / 180.0).tan();
let plate = polygon([[0, 0, 0], [length, 0, 0], [length - run, width, 0], [0, width, 0]]).to_face().extrude([0, 0, t]);
let marks = [];
let n = ((length - run - 10.0) / 5.0).floor().to_int();
for i in 1..(n + 1) {
    let x = i.to_float() * 5.0;
    let l = if i % 2 == 0 { 3.0 } else { 1.5 };
    marks.push(box_from_corners([x - 0.25, width - l, -1], [x + 0.25, width + 1.0, t + 1.0]));
}
plate - compound(marks) - cylinder([8.0, 10.0, -1], "Z", 2.5, t + 2.0)
