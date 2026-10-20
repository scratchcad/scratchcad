// Walk-in cold room door wedge stop: 150 mm long, 45 mm wide wedge rising to 32 mm, three 2 mm grip ribs underneath and a 10 mm hanging hole through the tall end
let length = 150.0; // [100.0, 200.0] Wedge length (mm)
let width = 45.0; // [30.0, 60.0] Wedge width (mm)
let rise = 32.0; // [20.0, 45.0] Wedge height (mm)
let w = face(polygon([[0, 0, 0], [length, 0, 0], [length, 0, rise], [length - 15.0, 0, rise], [0, 0, 3.0]])).extrude([0, width, 0]);
let ribs = [];
for i in 0..3 {
    let x = length * (i.to_float() + 1.0) / 4.0;
    ribs.push(box_from_corners([x - 2.0, -1.0, -1.0], [x + 2.0, width + 1.0, 1.0]));
}
w - compound(ribs) - cylinder([length - 12.0, -1.0, rise / 2.0], "Y", 5.0, width + 2.0)
