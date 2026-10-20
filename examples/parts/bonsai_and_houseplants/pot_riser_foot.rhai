// Plant pot riser foot: 40 x 30 mm block foot 20 mm tall with a 10 x 4 mm step that tucks under a pot rim and a ribbed top
let height = 20.0; // [12.0, 35.0] Riser height (mm)
let lip = 10.0; // [6.0, 15.0] Lip depth (mm)
let f = box_from_corners([0, 0, 0], [40.0, 30.0, height]);
let f = f.fillet(4.0, f.edges("|Z"));
let tuck = box_from_corners([-1.0, -1.0, height - 4.0], [lip, 31.0, height + 1.0]);
let ribs = [];
for i in 0..4 { ribs.push(box_from_corners([lip + 3.0 + i.to_float() * 7.0, -1.0, height - 1.0], [lip + 5.0 + i.to_float() * 7.0, 31.0, height + 1.0])); }
f - tuck - fuse_all(ribs)
