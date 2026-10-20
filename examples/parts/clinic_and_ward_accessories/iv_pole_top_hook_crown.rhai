// IV pole four-hook crown: 28 mm hub 40 mm tall that sleeves over a 19 mm pole (30 mm deep socket), with four 6 x 6 mm arms reaching 40 mm and turning up 15 mm to hold infusion bags
let pole_d = 19.0; // [16.0, 22.0] Pole diameter (mm)
let reach = 40.0; // [25.0, 60.0] Hook reach (mm)
let hooks = 4; // [2, 6] Number of hooks
let lift = 15.0; // [8.0, 25.0] Hook tip height (mm)
const hub_d = 28.0;
const hub_h = 40.0;
const s = 6.0;
let hub = cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_h);
let arms = [hub.chamfer(1.0, hub.edges(">Z"))];
for i in 0..hooks {
    let a = box_from_corners([0, -s / 2.0, hub_h - s - 4.0], [reach + hub_d / 2.0, s / 2.0, hub_h - 4.0]);
    let tip = box_from_corners([reach + hub_d / 2.0 - s, -s / 2.0, hub_h - 4.0 - s], [reach + hub_d / 2.0, s / 2.0, hub_h - 4.0 - s + lift]);
    arms.push((a + tip).rotate_z(i.to_float() * 360.0 / hooks.to_float()));
}
fuse_all(arms) - cylinder([0, 0, -1.0], "Z", pole_d / 2.0 + 0.2, 31.0)
