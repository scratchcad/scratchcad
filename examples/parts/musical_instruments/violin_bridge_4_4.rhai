// 4/4 violin bridge blank: 42 mm foot span, 33 mm tall, 4.3 mm thick at the feet thinning to 1.3 mm, heart and kidney cut-outs
let width = 42.0; // [38.0, 45.0] Foot width (mm)
let height = 33.0; // [30.0, 36.0] Height (mm)
let foot_t = 4.3; // [3.5, 5.0] Thickness at the feet (mm)
let top_t = 1.3; // [1.0, 2.0] Thickness at the top (mm)
let outline = polygon([[-width / 2.0, 0], [-width / 2.0 + 10.0, 0], [-6.0, 6.0], [6.0, 6.0], [width / 2.0 - 10.0, 0], [width / 2.0, 0], [width / 2.0 - 4.0, 12.0], [17.0, height - 3.0], [0, height], [-17.0, height - 3.0], [-width / 2.0 + 4.0, 12.0]]).to_face().extrude([0, 0, foot_t]).rotate_x(90.0).translate([0, foot_t / 2.0, 0]);
let b = outline & polygon([[-foot_t / 2.0, 0], [foot_t / 2.0, 0], [top_t / 2.0, height + 1.0], [-top_t / 2.0, height + 1.0]]).to_face().extrude([0, 0, 60.0]).rotate_x(90.0).rotate_z(90.0).translate([-30.0, 0, 0]);
let heart = cylinder([0, -5, 19.0], "Y", 2.5, 10.0) + box_centered(1.2, 10.0, 6.0).translate([0, 0, 15.0]);
let kidneys = cylinder([-9.0, -5, 13.0], "Y", 2.2, 10.0) + cylinder([9.0, -5, 13.0], "Y", 2.2, 10.0);
b - heart - kidneys
