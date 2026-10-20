// Bongo counter-hoop rim: 180 mm (7 in) head, 12 mm round-over rim 8 mm tall, 4 hook lugs with 6 mm slots
let head = 180.0; // [150.0, 230.0] Head diameter (mm)
let rim = 8.0; // [5.0, 12.0] Rim height (mm)
let w = 8.0; // [5.0, 12.0] Rim width (mm)
let ring = cylinder(head / 2.0 + w, rim) - cylinder([0, 0, -1], "Z", head / 2.0, rim + 2.0);
let r = ring.chamfer(2.0, ring.edges(">Z"));
let lugs = [];
for k in 0..4 { lugs.push((box_from_corners([head / 2.0 + w - 1.0, -8.0, 0], [head / 2.0 + w + 14.0, 8.0, 4.0]) - box_from_corners([head / 2.0 + w + 5.0, -3.0, -1], [head / 2.0 + w + 11.0, 3.0, 5.0])).rotate_z(k.to_float() * 90.0 + 45.0)); }
r + fuse_all(lugs)
