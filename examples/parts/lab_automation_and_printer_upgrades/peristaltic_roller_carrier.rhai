// Peristaltic pump roller carrier: two 40 mm discs 3 mm thick 14 mm apart on a 12 mm hub with a 5 mm D-shaft bore, 3 roller pins 3 mm on a 28 mm circle joining the discs, shown without the rollers
let disc_d = 40.0; // [30.0, 60.0] Disc diameter (mm)
let gap = 14.0; // [8.0, 20.0] Roller gap between the discs (mm)
let pin_circle = 28.0; // [18.0, 50.0] Roller pin circle (mm)
let roller_count = 3; // [2, 6] Number of rollers
let shaft = 5.0; // [3.0, 8.0] Motor shaft diameter (mm)
const disc_t = 3.0;
const pin_d = 3.0;
let r = disc_d / 2.0;
let pc = min(pin_circle, disc_d - 8.0) / 2.0;
let hub_r = max(6.0, shaft / 2.0 + 3.0);
let bottom = cylinder(r, disc_t);
let top = cylinder([0, 0, disc_t + gap], "Z", r, disc_t);
let hub = cylinder([0, 0, 0], "Z", hub_r, 2.0 * disc_t + gap + 5.0);
let pins = [];
for k in 0..roller_count {
    let a = k.to_float() * 2.0 * PI() / roller_count.to_float();
    pins.push(cylinder([pc * a.cos(), pc * a.sin(), disc_t - 0.5], "Z", pin_d / 2.0, gap + 1.0));
}
let carrier = fuse_all([bottom, top, hub] + pins);
let bore = cylinder([0, 0, -1], "Z", shaft / 2.0, 2.0 * disc_t + gap + 7.0) & box_centered(shaft + 2.0, shaft * 0.9, 4.0 * (disc_t + gap)).translate([0, -shaft * 0.05, 0]);
let grub = cylinder([0, 0, 2.0 * disc_t + gap + 2.5], "Y", 1.25, hub_r + 1.0);
carrier - bore - grub
