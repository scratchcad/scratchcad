// 150 mm ruler: 25 mm wide, 2 mm thick, bevelled edge, engraved mm ticks (0.3 mm deep), hanging hole
let length = 150.0; // [100.0, 300.0] Scale length (mm)
let width = 25.0; // [15.0, 40.0] Width (mm)
let thickness = 2.0; // [1.0, 4.0] Thickness (mm)
let total = length + 15.0;
let ruler = box(total, width, thickness);
ruler = ruler - polygon("YZ", [[-1, thickness + 1], [6.0, thickness + 0.01], [-1, thickness * 0.4]]).to_face().extrude([total + 2, 0, 0]).translate([-1, 0, 0]);
let ticks = [];
for i in 0..=(length.to_int()) {
    let l = if i % 10 == 0 { 7.0 } else if i % 5 == 0 { 5.0 } else { 3.0 };
    ticks.push(box_from_corners([5.0 + i.to_float() - 0.1, width - l, thickness - 0.3], [5.0 + i.to_float() + 0.1, width + 1.0, thickness + 1.0]));
}
ruler - compound(ticks) - cylinder([total - 6.0, width / 2.0, -1], "Z", 2.5, thickness + 2.0)
