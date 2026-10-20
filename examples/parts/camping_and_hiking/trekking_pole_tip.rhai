// Trekking pole rubber tip: 38 mm long, 12 mm bore for the carbide tip, 22 mm boot sole with tread
let bore = 12.0; // [8.0, 16.0] Bore (mm)
let length = 38.0; // [28.0, 50.0] Length (mm)
let foot_d = 22.0; // [16.0, 30.0] Foot diameter (mm)
let profile = sketch("XZ").move_to(0, 0).hline_to(foot_d / 2.0).vline_to(6.0).line_to(bore / 2.0 + 2.5, length * 0.6).vline_to(length).hline_to(0).close();
let tip = profile.face().revolve("Z", 360);
let treads = [];
for k in 0..4 { treads.push(box_centered(foot_d + 2.0, 2.0, 2.0).rotate_z(k.to_float() * 45.0)); }
tip - cylinder([0, 0, 8.0], "Z", bore / 2.0, length) - fuse_all(treads)
