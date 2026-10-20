// Electric juicer reamer cone: 75 mm base, 55 mm tall, 10 ribs, 8 mm hex drive socket
let base = 75.0; // [55.0, 100.0] Base diameter (mm)
let height = 55.0; // [35.0, 75.0] Height (mm)
let ribs = 10; // [6, 16] Number of ribs
let hex = 8.0; // [6.0, 12.0] Drive hex (mm)
let c = cone(base / 2.0, 3.0, height) + sphere([0, 0, height - 2.0], 4.0);
let rb = [];
for k in 0..ribs { rb.push(polygon([[0, -1.5, 0], [0, 1.5, 0], [0, 1.0, height], [0, -1.0, height]]).to_face().extrude([base / 2.0 + 3.0, 0, 0]).rotate_z(k.to_float() * 360.0 / ribs.to_float())); }
let grooves = fuse_all(rb) - cone(base / 2.0 - 2.5, 0.5, height);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
c - grooves - polygon(pts).to_face().extrude([0, 0, 15.0]).translate([0, 0, -1.0])
