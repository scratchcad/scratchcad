// Table saw featherboard: 150 x 70 x 19 mm body, 13 fingers 3 mm wide with 2 mm kerfs, 45 mm long at a 30 degree end, 2 x 8 mm adjustment slots, 3/4 in (19 x 9.5 mm) mitre bar underneath
let length = 150.0; // [100.0, 250.0] Body length (mm)
let width = 70.0; // [50.0, 100.0] Body width (mm)
let t = 19.0; // [12.0, 25.0] Thickness (mm)
let finger_l = 45.0; // [25.0, 60.0] Finger length (mm)
let kerf = 2.0; // [1.5, 3.0] Gap between fingers (mm)
let fingers = 13; // [6, 20] Number of fingers
let slope = width * (30.0 * PI() / 180.0).tan();
let body = polygon([[0, 0, 0], [length, 0, 0], [length - slope, width, 0], [0, width, 0]]).to_face().extrude([0, 0, t]);
let pitch = width / fingers.to_float();
let cuts = [];
for i in 1..fingers {
    let y = i.to_float() * pitch;
    let xe = length - slope * y / width;
    cuts.push(box_from_corners([xe - finger_l, y - kerf / 2.0, -1], [xe + 5.0, y + kerf / 2.0, t + 1.0]));
}
let slots = [];
for y in [width * 0.3, width * 0.7] { slots.push(box_from_corners([15.0, y - 4.0, -1], [length - finger_l - slope - 10.0, y + 4.0, t + 1.0])); }
let bar = box_from_corners([10.0, width / 2.0 - 9.5, -9.5], [length - finger_l - slope, width / 2.0 + 9.5, 0.5]);
body + bar - compound(cuts) - compound(slots)
