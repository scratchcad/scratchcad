// Worm-drive hose clamp, 40 mm: 9 mm stainless band 0.6 mm thick with perforations, housing and 7 mm hex-head slotted screw
let d = 40.0; // [20.0, 80.0] Clamp diameter (mm)
let r = d / 2.0;
let band = cylinder([0, 0, -4.5], "Z", r + 0.6, 9.0) - cylinder([0, 0, -5.5], "Z", r, 11.0);
let count = (2.0 * PI() * r * 0.8 / 2.5).to_int();
let slots = [];
for k in 0..count { slots.push(box_centered(2.0, 1.2, 4.0).translate([r + 0.3, 0, 0]).rotate("Z", 110.0 + k.to_float() * 320.0 / count.to_float())); }
band -= fuse_all(slots);
let housing = box_centered(12.0, 7.0, 13.0).translate([0, r + 3.4, 0]);
let screw = cylinder([-9.0, r + 4.5, 0], "X", 3.0, 18.0);
let rc = 7.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * 60.0 * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(hp).to_face().extrude(5.0).rotate_y(-90.0).translate([-9.0, r + 4.5, 0]) - box_centered(1.0, 8.0, 1.2).translate([-14.0, r + 4.5, 0]);
fuse_all([band, housing, screw, head])
