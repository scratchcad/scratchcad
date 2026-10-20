// Aluminium PV mid clamp for 35 mm framed panels: 50 mm long, 44 mm wide top with serrated grip wings, 20 mm hollow box leg 30 mm tall, 8.5 mm hole for an M8 T-bolt
let length = 50.0; // [30.0, 80.0] Clamp length along the rail (mm)
let top_w = 44.0; // [36.0, 60.0] Top width (mm)
let leg_w = 20.0; // [16.0, 26.0] Leg width, the gap between panels (mm)
let leg_h = 30.0; // [10.0, 45.0] Leg height (mm)
let bolt_d = 8.5; // [6.5, 10.5] Bolt hole diameter (mm)
const top_t = 5.0;
const wall = 2.5;
let lw = min(leg_w, top_w - 10.0);
let h = leg_h + top_t;
let profile = polygon("XZ", [[-top_w / 2.0, leg_h], [-lw / 2.0, leg_h], [-lw / 2.0, 0], [lw / 2.0, 0], [lw / 2.0, leg_h],
    [top_w / 2.0, leg_h], [top_w / 2.0, h - 1.0], [top_w / 2.0 - 1.0, h], [-top_w / 2.0 + 1.0, h], [-top_w / 2.0, h - 1.0]]);
let c = profile.to_face().extrude([0, length, 0]);
c -= box_from_corners([-lw / 2.0 + wall, -1, -1], [lw / 2.0 - wall, length + 1.0, leg_h - 1.0]);
let teeth = [];
for s in [-1.0, 1.0] {
    for i in 0..5 {
        let x = s * (lw / 2.0 + 2.0 + i.to_float() * ((top_w - lw) / 2.0 - 3.0) / 5.0);
        teeth.push(box_centered(1.0, length + 2.0, 1.0).rotate_y(45.0).translate([x, length / 2.0, leg_h]));
    }
}
c -= fuse_all(teeth);
c -= cylinder([0, length / 2.0, -1], "Z", bolt_d / 2.0, h + 2.0);
c - cylinder([0, length / 2.0, h - 2.0], "Z", bolt_d / 2.0 + 3.5, 3.0)
