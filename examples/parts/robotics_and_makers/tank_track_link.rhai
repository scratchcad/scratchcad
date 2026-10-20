// Plastic tank track link for small tracked robots: 42 mm wide, 15 mm pitch, 6 mm thick shoe with a grouser bar, two hinge knuckles and a centre knuckle on 3 mm pins, central drive-tooth window
let width = 42.0; // [25.0, 80.0] Track width (mm)
let pitch = 15.0; // [10.0, 25.0] Link pitch (mm)
let t = 6.0; // [4.0, 10.0] Link thickness (mm)
let grouser = 3.0; // [0.0, 6.0] Grouser height (mm)
const pin = 3.0;
const gap = 0.4;
let kw = width / 4.0;
let shoe = box_from_corners([0, -width / 2.0, 0], [pitch - t / 2.0 - gap, width / 2.0, t]);
let left = cylinder([0, -width / 2.0, t / 2.0], "Y", t / 2.0, kw) + cylinder([0, width / 2.0 - kw, t / 2.0], "Y", t / 2.0, kw);
let centre = cylinder([pitch, -kw + gap, t / 2.0], "Y", t / 2.0, 2.0 * kw - 2.0 * gap) + box_from_corners([pitch - t / 2.0 - gap - 0.01, -kw + gap, 0], [pitch, kw - gap, t]);
let l = fuse_all([shoe, left, centre]);
if grouser > 0.0 { l += box_from_corners([pitch * 0.25, -width / 2.0, -grouser], [pitch * 0.55, width / 2.0, 0.01]).chamfer(0.8, "|Y and <Z"); }
l -= cylinder([0, -width, t / 2.0], "Y", pin / 2.0, 2.0 * width) + cylinder([pitch, -width, t / 2.0], "Y", pin / 2.0, 2.0 * width);
l -= box_from_corners([-t, -kw - gap, -grouser - 1.0], [t / 2.0 + gap, kw + gap, t + 1.0]);
l - box_from_corners([t / 2.0 + gap + 1.0, -kw / 2.0, -grouser - 1.0], [pitch - t / 2.0 - gap - 1.0, kw / 2.0, t + 1.0])
