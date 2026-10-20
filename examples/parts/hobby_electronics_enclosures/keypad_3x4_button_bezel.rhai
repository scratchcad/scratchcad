// 3x4 keypad bezel for 12 x 12 mm tactile switches with square caps: 12 x 12.4 mm holes on 15 mm pitch, 54 x 69 x 2.5 mm plate, 0.6 mm chamfered openings, 4 standoffs 6 mm for M2.5 on 46 x 61 mm, rear ribs between rows
let cols = 3; // [1, 6] Number of key columns
let rows = 4; // [1, 6] Number of key rows
let pitch = 15.0; // [13.0, 20.0] Key pitch (mm)
let key = 12.4; // [8.0, 14.0] Key opening (mm)
let thick = 2.5; // [1.5, 4.0] Plate thickness (mm)
let standoff = 6.0; // [3.0, 12.0] Standoff height (mm)
let kp = min(key, pitch - 1.6);
let w = cols.to_float() * pitch + 9.0;
let h = rows.to_float() * pitch + 9.0;
let plate = box_centered(w, h, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let parts = [plate];
for j in 1..rows {
    let y = -h / 2.0 + 4.5 + j.to_float() * pitch;
    parts.push(box_from_corners([-w / 2.0 + 4.5, y - 0.6, thick - 0.5], [w / 2.0 - 4.5, y + 0.6, thick + 2.0]));
}
let drills = [];
for x in [-w / 2.0 + 4.0, w / 2.0 - 4.0] {
    for y in [-h / 2.0 + 4.0, h / 2.0 - 4.0] {
        parts.push(cylinder([x, y, thick - 0.5], "Z", 2.75, standoff + 0.5));
        drills.push(cylinder([x, y, 1.0], "Z", 1.1, standoff + thick));
    }
}
let body = fuse_all(parts);
let keys = [];
for i in 0..cols {
    for j in 0..rows {
        let x = -w / 2.0 + 4.5 + (i.to_float() + 0.5) * pitch;
        let y = -h / 2.0 + 4.5 + (j.to_float() + 0.5) * pitch;
        keys.push(box_centered(kp, kp, thick * 4.0).translate([x, y, 0]));
    }
}
let ka = cols.to_float() * pitch / 2.0;
let kb = rows.to_float() * pitch / 2.0;
let cut = body - compound(keys) - compound(drills);
cut.chamfer(0.6, cut.edges("<Z").filter(|e| e.center().x.abs() < ka && e.center().y.abs() < kb))
