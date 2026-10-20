// Truck wheel chock: 250 mm long, 140 mm wide, 150 mm tall wedge with a 45 degree tyre face, 5 anti-slip grooves 6 mm deep on the tyre face, 30 mm hand hole and a 4 x 4 mm ribbed base
let length = 250.0; // [180.0, 350.0] Chock length (mm)
let width = 140.0; // [100.0, 200.0] Chock width (mm)
let height = 150.0; // [100.0, 220.0] Chock height (mm)
let grooves = 5; // [2, 8] Number of tyre face grooves
let profile = polygon("XZ", [[0, 0], [length, 0], [length, 20.0], [height + 20.0, height], [height, height]]);
let body = profile.to_face().extrude([0, width, 0]);
let cuts = [];
for i in 0..grooves {
    let t = (i.to_float() + 1.0) / (grooves.to_float() + 1.0);
    cuts.push(box_centered(12.0, width + 2.0, 12.0).rotate_y(-45.0).translate([height * t, width / 2.0, height * t]));
}
let hand = cylinder([length - 40.0, -1.0, 40.0], "Y", 15.0, width + 2.0);
let base_ribs = [];
for i in 0..6 { base_ribs.push(box_centered(4.0, width + 2.0, 8.0).translate([30.0 + i.to_float() * 35.0, width / 2.0, 0])); }
body - compound(cuts) - hand - compound(base_ribs)
