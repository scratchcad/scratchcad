// Venetian blind tilt wand hook: 6 mm hex wand socket 20 mm, 3 mm wire-style hook loop 10 mm
let hex = 6.0; // [4.0, 10.0] Wand hex (mm)
let socket_l = 20.0; // [12.0, 30.0] Socket length (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([(hex / 2.0 + 1.5) * 2.0 / 3.0.sqrt() * a.cos(), (hex / 2.0 + 1.5) * 2.0 / 3.0.sqrt() * a.sin()]); }
let outer = polygon(pts).to_face().extrude([0, 0, socket_l]);
let ipts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; ipts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let inner = polygon(ipts).to_face().extrude([0, 0, socket_l - 3.0]).translate([0, 0, -1.0]);
let hook = cylinder([0, -1.5, socket_l + 6.0], "Y", 6.5, 3.0) - cylinder([0, -2.0, socket_l + 6.0], "Y", 3.5, 4.0) - box_from_corners([-8.0, -3.0, socket_l + 6.0], [0, 3.0, socket_l + 14.0]);
let neck = cylinder([0, 0, socket_l - 0.01], "Z", 1.5, 3.0);
outer - inner + neck + hook
