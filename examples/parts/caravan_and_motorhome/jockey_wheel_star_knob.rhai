// Jockey wheel clamp star knob: 70 mm five-lobed knob 25 mm thick with an M12 nut pocket (19 mm AF, 10 mm deep), 12.5 mm through bore and a 30 mm hub boss 10 mm tall
let span = 70.0; // [55.0, 90.0] Knob span (mm)
let t = 25.0; // [18.0, 32.0] Knob thickness (mm)
const lobes = 5;
let lobe_r = span / 2.0 * 0.32;
let core = cylinder([0, 0, 0], "Z", span / 2.0 - lobe_r, t);
let parts = [core];
for i in 0..lobes { let a = (90.0 + 72.0 * i.to_float()) * PI() / 180.0; parts.push(cylinder([(span / 2.0 - lobe_r) * cos(a), (span / 2.0 - lobe_r) * sin(a), 0], "Z", lobe_r, t)); }
let k = fuse_all(parts);
let hub = cylinder([0, 0, t - 0.01], "Z", 15.0, 10.0);
let hr = 19.0 / 2.0 / cos(PI() / 6.0) + 0.2;
let hexp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hexp.push([hr * cos(a), hr * sin(a), 0]); }
let nut = face(polygon(hexp)).extrude([0, 0, 11.0]).translate([0, 0, -1.0]);
k + hub - nut - cylinder([0, 0, -1.0], "Z", 6.25, t + 12.0)
