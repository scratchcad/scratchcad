// Overbed table height adjustment knob: 50 mm three-lobe knob 18 mm thick on a 24 mm boss 30 mm tall, with a 6.8 mm M8 tap hole through and a 1 mm chamfer on the boss
let span = 50.0; // [40.0, 70.0] Lobe tip circle diameter (mm)
let thick = 18.0; // [12.0, 25.0] Lobe thickness (mm)
let boss_h = 30.0; // [20.0, 40.0] Boss height (mm)
const boss_d = 24.0;
let lobe_r = span / 6.0 + 1.0;
let boss = cylinder([0, 0, 0], "Z", boss_d / 2.0, boss_h);
let parts = [boss.chamfer(1.0, boss.edges(">Z")), cylinder([0, 0, 0], "Z", span / 2.0 - lobe_r + 2.0, thick)];
for i in 0..3 {
    let a = i.to_float() * 120.0 * PI() / 180.0;
    let c = span / 2.0 - lobe_r;
    parts.push(cylinder([c * cos(a), c * sin(a), 0], "Z", lobe_r, thick));
}
fuse_all(parts) - cylinder([0, 0, -1.0], "Z", 3.4, boss_h + 2.0)
