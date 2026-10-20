// 5-string banjo bridge: 5/8 in (15.9 mm) tall, 70 mm wide, three feet, 5 string notches
let width = 70.0; // [60.0, 80.0] Width (mm)
let height = 15.9; // [12.0, 20.0] Height (mm)
let t_foot = 4.5; // [3.0, 6.0] Foot thickness (mm)
let t_top = 2.0; // [1.5, 3.0] Top thickness (mm)
let blank = polygon([[0, -t_foot / 2.0, 0], [0, t_foot / 2.0, 0], [0, t_top / 2.0, height], [0, -t_top / 2.0, height]]).to_face().extrude([width, 0, 0]).translate([-width / 2.0, 0, 0]);
let arches = cylinder([-17.0, -5.0, 0], "Y", 12.0, 10.0) + cylinder([17.0, -5.0, 0], "Y", 12.0, 10.0);
let a = arches & box_from_corners([-30.0, -10.0, -1.0], [30.0, 10.0, 7.0]);
let notches = [];
for k in 0..5 { notches.push(cylinder([-24.0 + k.to_float() * 12.0, -5.0, height], "Y", 0.5, 10.0)); }
blank - a - fuse_all(notches)
