// Screw-clamp end stop for a TS35 DIN rail, like Phoenix E/UK: 9.5 mm wide, 45 mm long, 30 mm tall, hooks under both 1 mm rail flanges, M4 clamp screw hole with captive nut slot
let width = 9.5; // [6.0, 15.0] Width along the rail (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let length = 45.0; // [40.0, 60.0] Length across the rail (mm)
const flange_gap = 1.2;
let hl = length / 2.0;
let side = polygon("YZ", [[-hl, 0], [hl, 0], [hl, height * 0.45], [9.0, height], [-9.0, height], [-hl, height * 0.45]]).to_face().extrude([width, 0, 0]);
let hooks = [];
for s in [-1.0, 1.0] {
    let y_out = s * 19.6;
    hooks.push(box_from_corners([0, s * 17.7, -2.4], [width, y_out, 0.1]));
    hooks.push(box_from_corners([0, s * 16.2, -2.4], [width, y_out, -2.4 + 1.2]));
}
let stop = fuse_all([side] + hooks);
stop -= cylinder([width / 2.0, 0, -5], "Z", 2.1, height + 10.0);
stop -= box_centered(width + 2.0, 7.2, 3.4).translate([width / 2.0, 0, height * 0.5]);
stop -= box_centered(width * 0.6, 14.0, 1.5).translate([width / 2.0, 0, height]);
stop.chamfer(0.5, "|X and >Z")
