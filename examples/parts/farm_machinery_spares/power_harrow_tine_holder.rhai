// Power harrow rotor tine holder: 70 mm hub 40 mm tall with a 35 mm bore and a 10 mm keyway 3.3 mm deep, two 34 mm wide arms reaching out to 230 mm across, each ending in a 22 x 52 mm boss with a 16.5 x 46 mm pocket through it for the tine shank and a 12.5 mm cross pin hole
let hub_d = 70.0; // [56.0, 90.0] Hub diameter (mm)
let span = 230.0; // [180.0, 300.0] Overall span (mm)
let height = 40.0; // [30.0, 55.0] Hub height (mm)
let shaft_d = 35.0; // [25.0, 45.0] Shaft bore (mm)
let pocket_w = 16.5; // [12.5, 20.5] Tine shank pocket width (mm)
let pocket_len = 46.0; // [36.0, 56.0] Tine shank pocket length (mm)
const arm_w = 34.0;
const arm_t = 24.0;
const key_w = 10.0;
const pin_d = 12.5;
let rh = max(hub_d / 2.0, shaft_d / 2.0 + 10.0);
let half = span / 2.0;
let bw = pocket_w + 6.0;
let bl = pocket_len + 6.0;
let parts = [cylinder(rh, height)];
let cutters = [
    cylinder([0, 0, -1.0], "Z", shaft_d / 2.0, height + 2.0),
    box_from_corners([0, -key_w / 2.0, -1.0], [shaft_d / 2.0 + 3.3, key_w / 2.0, height + 1.0]),
];
for s in [-1.0, 1.0] {
    let xc = s * (half - bw / 2.0);
    parts.push(box_from_corners([min(s * (rh - 2.0), xc), -arm_w / 2.0, (height - arm_t) / 2.0], [max(s * (rh - 2.0), xc), arm_w / 2.0, (height + arm_t) / 2.0]));
    parts.push(box_from_corners([xc - bw / 2.0, -bl / 2.0, 0], [xc + bw / 2.0, bl / 2.0, height]));
    cutters.push(box_from_corners([xc - pocket_w / 2.0, -pocket_len / 2.0, -1.0], [xc + pocket_w / 2.0, pocket_len / 2.0, height + 1.0]));
    cutters.push(cylinder([xc, -arm_w, height / 2.0], "Y", pin_d / 2.0, 2.0 * arm_w));
}
fuse_all(parts) - fuse_all(cutters)
