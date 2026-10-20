// Outboard throttle friction knob: 36 mm six-lobed knob 18 mm tall with 5 mm lobes, the lobe tips chamfered at the top, a 14 mm boss 6 mm long underneath, and an M6 blind tapped hole (5 mm core) 16 mm deep for the friction screw
let knob_d = 36.0; // [25.0, 50.0] Knob diameter (mm)
let height = 18.0; // [12.0, 25.0] Knob height (mm)
let lobes = 6; // [4, 8] Number of grip lobes
const boss_d = 14.0;
let r = knob_d / 2.0;
let body = cylinder([0, 0, 0], "Z", r - 3.0, height);
let parts = [body];
for i in 0..lobes {
    let a = (i.to_float() * 360.0 / lobes.to_float()) * PI() / 180.0;
    parts.push(cylinder([(r - 5.0) * cos(a), (r - 5.0) * sin(a), 0], "Z", 5.0, height));
}
let knob = fuse_all(parts);
let rim = face(polygon([[0, 0, 0], [r + 1.0, 0, 0], [r + 1.0, 0, height - 2.5], [r - 1.5, 0, height], [0, 0, height]])).revolve("Z", 360.0);
let knob = knob & rim;
let knob = knob + cylinder([0, 0, -6.0], "Z", boss_d / 2.0, 6.5);
knob - cylinder([0, 0, -7.0], "Z", 2.5, 17.0)
