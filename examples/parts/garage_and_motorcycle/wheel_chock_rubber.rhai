// Rubber wheel chock for cars: 250 mm long, 120 mm wide, 125 mm tall, concave tyre face (20 mm deep), ribbed base and a 90 x 25 mm carry slot
let length = 250.0; // [180.0, 350.0] Length (mm)
let width = 120.0; // [90.0, 180.0] Width (mm)
let height = 125.0; // [80.0, 180.0] Height (mm)
let face_depth = 20.0; // [8.0, 30.0] Tyre face hollow depth (mm)
let ribs = 6; // [3, 10] Number of base ribs
const rib_depth = 5.0;
// the concave face runs from the toe (0, 15) to (0.55 L, H); its middle is pushed into the body
let fx = length * 0.55;
let mx = fx / 2.0;
let mz = (15.0 + height) / 2.0;
let n_len = sqrt(fx * fx + (height - 15.0) * (height - 15.0));
let prof = sketch("XZ").move_to(0, 0).hline_to(length).vline_to(18.0).line_to(length * 0.72, height).hline_to(fx)
    .arc_to(mx + face_depth * (height - 15.0) / n_len, mz - face_depth * fx / n_len, 0, 15.0).close();
let chock = prof.to_face().extrude([0, width, 0]);
let pitch = length / (ribs.to_float() + 1.0);
let grooves = [];
for i in 1..=ribs { grooves.push(box_from_corners([i.to_float() * pitch - 6.0, -1.0, -1.0], [i.to_float() * pitch + 6.0, width + 1.0, rib_depth])); }
let slot = box_from_corners([fx + 5.0, (width - 90.0) / 2.0, height - 45.0], [fx + 30.0, (width + 90.0) / 2.0, height + 1.0]);
chock - compound(grooves) - slot
