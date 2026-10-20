// Hex terrain tile: 50 mm across flats, 6 mm thick, interlocking 4 mm dovetail tabs and sockets on alternate edges
let flats = 50.0; // [30.0, 80.0] Across flats (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let rc = flats / 3.0.sqrt();
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude([0, 0, t]);
let tab = polygon([[flats / 2.0 - 0.01, -3.0], [flats / 2.0 + 4.0, -4.5], [flats / 2.0 + 4.0, 4.5], [flats / 2.0 - 0.01, 3.0]]).to_face().extrude([0, 0, t]);
let sock = polygon([[flats / 2.0 - 4.2, -4.7], [flats / 2.0 + 0.01, -3.2], [flats / 2.0 + 0.01, 3.2], [flats / 2.0 - 4.2, 4.7]]).to_face().extrude([0, 0, t + 2.0]).translate([0, 0, -1.0]);
let tabs = [];
let socks = [];
for k in 0..3 { tabs.push(tab.rotate_z(k.to_float() * 120.0)); socks.push(sock.rotate_z(k.to_float() * 120.0 + 60.0)); }
hex + fuse_all(tabs) - fuse_all(socks)
