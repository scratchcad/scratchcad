// Monitor arm ball-head base: 25 mm ball on a 10 mm neck 12 mm long rising from a 40 mm round base 8 mm thick with a 3 mm chamfer, 3/8-16 tapped hole (8 mm core) 10 mm deep underneath and two 3 mm anti-twist pin holes on 26 mm
let ball_d = 25.0; // [16.0, 32.0] Ball diameter (mm)
let neck_len = 12.0; // [6.0, 25.0] Neck length (mm)
let base_d = 40.0; // [34.0, 60.0] Base diameter (mm)
const base_h = 8.0;
const neck_d = 10.0;
let r = base_d / 2.0;
let base = face(polygon([[0, 0, 0], [r, 0, 0], [r, 0, base_h - 3.0], [r - 3.0, 0, base_h], [0, 0, base_h]])).revolve("Z", 360.0);
let neck = cylinder([0, 0, base_h - 0.5], "Z", neck_d / 2.0, neck_len + 1.0);
let zc = base_h + neck_len + ball_d / 2.0 - 2.0;
let ball = sphere([0, 0, zc], ball_d / 2.0);
let cuts = [cylinder([0, 0, -1.0], "Z", 4.0, 11.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * 13.0, 0, -1.0], "Z", 1.5, 5.0));
}
base + neck + ball - fuse_all(cuts)
