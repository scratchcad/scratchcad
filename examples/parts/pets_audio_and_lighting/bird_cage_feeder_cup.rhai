// Bird cage feeder cup: 70 x 50 mm D-shaped cup 45 mm deep, 2 mm walls, two wire hooks 2.5 mm thick that hang on cage bars
let w = 70.0; // [50.0, 100.0] Width (mm)
let h = 45.0; // [30.0, 60.0] Depth (mm)
let outline = sketch().move_to(-w / 2.0, 0).line_to(w / 2.0, 0).arc_to(0, 50.0, -w / 2.0, 0).close();
let cup = outline.to_face().extrude(h) - outline.to_face().offset(-2.0).extrude(h).translate([0, 0, 2.0]);
let hooks = [];
for x in [-w / 3.0, w / 3.0] { hooks.push(box_from_corners([x - 3.0, -1.0, h - 2.0], [x + 3.0, 0, h + 12.0]) + box_from_corners([x - 3.0, -9.0, h + 10.0], [x + 3.0, 0, h + 12.0]) + box_from_corners([x - 3.0, -9.0, h + 4.0], [x + 3.0, -7.0, h + 12.0])); }
fuse_all([cup] + hooks)
