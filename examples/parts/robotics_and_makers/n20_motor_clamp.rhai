// Saddle clamp for an N20 micro gear motor (12 mm can with 10 mm flats): 12 mm wide strap, 1.6 mm thick, hugging the flat-sided can, two M2 screw ears 20 mm apart
let can_d = 12.0; // [10.0, 14.0] Motor can diameter (mm)
let flats = 10.0; // [8.0, 12.0] Distance across the flats (mm)
let strap_w = 12.0; // [6.0, 20.0] Strap width (mm)
let ear_spacing = 20.0; // [18.0, 28.0] Screw spacing (mm)
const t = 1.6;
let r = can_d / 2.0 + 0.1;
let h = min(flats, can_d - 1.0) + 0.2;
let es = max(ear_spacing, 2.0 * r + 2.0 * t + 4.0);
let outer = cylinder([0, 0, h / 2.0], "Y", r + t, strap_w) & box_from_corners([-es, -1.0, 0], [es, strap_w + 1.0, h + t]);
let pocket = cylinder([0, -1, h / 2.0], "Y", r, strap_w + 2.0) & box_from_corners([-es, -2.0, -1.0], [es, strap_w + 2.0, h]);
let ears = box_from_corners([-es / 2.0 - 3.0, 0, 0], [es / 2.0 + 3.0, strap_w, t]);
let c = (outer + ears) - pocket;
for s in [-1.0, 1.0] { c -= cylinder([s * es / 2.0, strap_w / 2.0, -1], "Z", 1.1, t + 2.0); }
c
