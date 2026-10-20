// 40 mm round speaker grille: 50 mm disc 2 mm thick, 2 mm holes on a 3 mm hex grid within 34 mm, 41 mm locating ring 2 mm tall on the back, 3 x 2.5 mm screw holes on 47 mm PCD
let diameter = 50.0; // [46.0, 70.0] Grille diameter (mm)
let thick = 2.0; // [1.2, 3.5] Grille thickness (mm)
let speaker = 40.0; // [28.0, 57.0] Speaker diameter (mm)
let hole = 2.0; // [1.2, 3.0] Sound hole diameter (mm)
let pitch = 3.0; // [2.0, 5.0] Hole pitch (mm)
let r = max(diameter / 2.0, speaker / 2.0 + 5.0);
let rs = speaker / 2.0 + 0.5;
let open_r = speaker * 0.85 / 2.0;
let pitch_ok = max(pitch, hole + 0.6);
let disc = cylinder(r, thick);
let disc = disc.chamfer(0.6, disc.edges(">Z"));
let ring = cylinder([0, 0, -2.0], "Z", rs + 1.2, 2.5) - cylinder([0, 0, -3.0], "Z", rs, 4.0);
let body = disc + ring;
let holes = [];
let n = (open_r / pitch_ok).floor().to_int() + 1;
let dy = pitch_ok * 3.0.sqrt() / 2.0;
for j in -n..=n {
    for i in -n..=n {
        let x = i.to_float() * pitch_ok + (if j % 2 == 0 { 0.0 } else { pitch_ok / 2.0 });
        let y = j.to_float() * dy;
        if (x * x + y * y).sqrt() <= open_r - hole / 2.0 {
            holes.push(cylinder([x, y, -1], "Z", hole / 2.0, thick + 2.0));
        }
    }
}
let rp = (rs + 1.2 + r) / 2.0;
for k in 0..3 {
    let a = (k.to_float() * 120.0 + 90.0) * PI() / 180.0;
    holes.push(cylinder([rp * a.cos(), rp * a.sin(), -3.0], "Z", 1.25, thick + 4.0));
}
body - compound(holes)
