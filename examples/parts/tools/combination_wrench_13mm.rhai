// 13 mm combination wrench: open end at 15 deg, 12-point-style hex ring end offset 15 deg, 150 mm between ends, 5 mm handle
let size = 13.0; // [8.0, 24.0] Size across flats (mm)
let len = 150.0; // [100.0, 250.0] Length between ends (mm)
let rh = size * 1.25;
let open = cylinder(rh, 6.0) - (box_from_corners([-rh * 2.0, -size / 2.0, -1], [0, size / 2.0, 7]) + cylinder([0, 0, -1], "Z", size / 2.0, 8.0)).rotate("Z", 15.0);
let handle = box_from_corners([rh * 0.6, -size * 0.45, 0.5], [len - rh * 0.6, size * 0.45, 5.5]);
let rc = size / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 15.0) * PI() / 180.0; hp.push([len + rc * a.cos(), rc * a.sin()]); }
let ring = cylinder([len, 0, -0.5], "Z", size * 0.95, 7.0) - polygon(hp).to_face().extrude(9.0).translate([0, 0, -1.5]) - polygon(hp).to_face().extrude(9.0).translate([0, 0, -1.5]).rotate([len, 0, 0], "Z", 30.0);
fuse_all([open, handle, ring])
