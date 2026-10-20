// 08B (1/2 in) roller chain, 6 links: 12.7 mm pitch, 8.51 mm rollers, 7.75 mm inner width, 1.6 mm plates
let pitch = 12.7; // [6.35, 25.4] Pitch (mm)
let roller_d = 8.51; // [3.3, 16.0] Roller diameter (mm)
let inner_w = 7.75; // [3.0, 17.0] Inner width (mm)
let plate_t = 1.6; // [0.8, 4.0] Plate thickness (mm)
let plate_h = 11.8; // [6.0, 24.0] Plate height (mm)
let links = 6; // [2, 20] Links
let plate = (cylinder([0, 0, 0], "Y", plate_h / 2.0, plate_t) + cylinder([pitch, 0, 0], "Y", plate_h / 2.0, plate_t) + box_from_corners([0, 0, -plate_h * 0.38], [pitch, plate_t, plate_h * 0.38]))
    - cylinder([0, -1, 0], "Y", roller_d * 0.26, plate_t + 2.0) - cylinder([pitch, -1, 0], "Y", roller_d * 0.26, plate_t + 2.0);
let parts = [];
for i in 0..links {
    let x = i.to_float() * pitch;
    let gap = if i % 2 == 0 { inner_w / 2.0 } else { inner_w / 2.0 + plate_t };
    parts.push(plate.translate([x, gap, 0]));
    parts.push(plate.translate([x, -gap - plate_t, 0]));
    parts.push(cylinder([x, -inner_w / 2.0, 0], "Y", roller_d / 2.0, inner_w));
    parts.push(cylinder([x, -inner_w / 2.0 - 2.0 * plate_t - 0.6, 0], "Y", roller_d * 0.25, inner_w + 4.0 * plate_t + 1.2));
}
compound(parts)
