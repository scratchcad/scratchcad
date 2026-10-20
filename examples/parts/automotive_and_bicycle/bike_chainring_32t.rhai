// 32-tooth 104 BCD MTB chainring: 1/2 in chain pitch, 7.75 mm rollers, 3 mm plate, four 10.5 mm bolt holes on tabs
let teeth = 32; // [30, 44] Teeth
let thick = 3.0; // [2.0, 4.0] Plate thickness (mm)
let bcd = 104.0; // [96.0, 110.0] Bolt circle diameter (mm)
const pitch = 12.7;
let n = teeth.to_float();
let rp = pitch / (2.0 * (PI() / n).sin());
let ro = rp + 0.3 * pitch;
let seat = 7.75 / 2.0 + 0.1;
let rin = rp - seat - 4.0;
let ring = cylinder(ro, thick) - cylinder([0, 0, -1], "Z", rin, thick + 2.0);
let gap = cylinder([rp, 0, -1], "Z", seat, thick + 2.0) + polygon([[rp, -seat], [ro + 1.0, -seat - 2.0], [ro + 1.0, seat + 2.0], [rp, seat]]).to_face().extrude(thick + 2.0).translate([0, 0, -1]);
for i in 0..teeth { ring -= gap.rotate("Z", i.to_float() * 360.0 / n); }
for i in 0..4 {
    let tab = cylinder([bcd / 2.0, 0, 0], "Z", 9.0, thick) + box_from_corners([bcd / 2.0, -9.0, 0], [rin + 2.0, 9.0, thick]);
    ring = ring + tab.rotate("Z", 45.0 + i.to_float() * 90.0);
}
for i in 0..4 { ring -= cylinder([bcd / 2.0, 0, -1], "Z", 5.25, thick + 2.0).rotate("Z", 45.0 + i.to_float() * 90.0); }
ring
