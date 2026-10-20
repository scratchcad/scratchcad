// Lens follow-focus gear ring: module 0.8 (32 pitch) cine gear, 96 teeth (78.4 mm pitch diameter) on a 7 mm wide ring, 68 mm bore for the lens barrel, split so it clamps on with a tie
let teeth = 96; // [60, 140] Number of teeth
let module_size = 0.8; // [0.7, 1.0] Gear module (mm)
let width = 7.0; // [5.0, 12.0] Gear width (mm)
let bore = 68.0; // [40.0, 72.0] Lens bore (mm)
let pd = teeth.to_float() * module_size;
let ra = pd / 2.0 + module_size;
let rf = pd / 2.0 - 1.25 * module_size;
let pts = [];
// trapezoidal teeth: root, flank, tip, flank, root per tooth
for i in 0..teeth {
    let a0 = i.to_float() * 2.0 * PI() / teeth.to_float();
    let step = 2.0 * PI() / teeth.to_float();
    for f in [[0.0, rf], [0.2, rf], [0.35, ra], [0.65, ra], [0.8, rf]] {
        let a = a0 + f[0] * step;
        pts.push([f[1] * a.cos(), f[1] * a.sin()]);
    }
}
let gear = polygon("XY", pts).to_face().extrude([0, 0, width]);
// keep at least 2 mm of ring under the teeth
let bore_r = (bore / 2.0).min(rf - 2.0);
let ring = gear - cylinder([0, 0, -1.0], "Z", bore_r, width + 2.0);
let split = box_from_corners([-0.75, 0, -1.0], [0.75, ra + 1.0, width + 1.0]).rotate_z(-90.0);
ring - split
