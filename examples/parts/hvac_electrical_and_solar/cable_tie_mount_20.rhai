// Adhesive cable tie mount 20 x 20 mm, 6 mm tall, four-way crossing tunnels for ties up to 4.8 mm wide, chamfered square base
let size = 20.0; // [12.0, 40.0] Base size (mm)
let height = 6.0; // [4.0, 12.0] Height (mm)
let tie_w = 4.8; // [2.5, 9.0] Tie width (mm)
const base_t = 1.2;
const tie_t = 1.4;
let tw = min(tie_w, size * 0.4);
let base = box_centered(size, size, base_t).translate([0, 0, base_t / 2.0]).chamfer(0.5, ">Z").fillet(1.5, "|Z");
let dome = sphere([0, 0, height - size * 0.45], size * 0.45) & box_centered(size, size, height).translate([0, 0, height / 2.0]) & cylinder(size * 0.35, height + 1.0);
let m = base + dome;
let tunnel_z = base_t + 0.4 + tie_t / 2.0;
for a in [0.0, 90.0] { m -= box_centered(size + 2.0, tw, tie_t).translate([0, 0, tunnel_z]).rotate_z(a); }
m - cylinder([0, 0, -1], "Z", 1.6, height + 2.0)
