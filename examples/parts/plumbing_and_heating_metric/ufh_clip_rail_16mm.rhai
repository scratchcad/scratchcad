// Underfloor heating clip rail for 16 mm pipe: 200 mm rail 30 mm wide 4 mm base, snap cradles every 50 mm (16.3 mm bore, 13 mm mouth, 8 mm wide), 4 mm nail holes between cradles
let length = 200.0; // [100.0, 400.0] Rail length (mm)
let pipe = 16.0; // [12.0, 20.0] Pipe diameter (mm)
let pitch = 50.0; // [30.0, 100.0] Pipe pitch (mm)
let base_t = 4.0; // [3.0, 6.0] Base thickness (mm)
let cradle_w = 8.0; // [5.0, 14.0] Cradle width (mm)
const rail_w = 30.0;
let ri = pipe / 2.0 + 0.15;
let ro = ri + 2.0;
let zc = base_t + ri + 1.0;
let n = (length / pitch).floor().to_int();
let shapes = [box_from_corners([0, -rail_w / 2.0, 0], [length, rail_w / 2.0, base_t])];
let cuts = [];
for k in 0..n {
    let x = pitch / 2.0 + k.to_float() * pitch;
    shapes.push(cylinder([x, -cradle_w / 2.0, zc], "Y", ro, cradle_w));
    shapes.push(box_from_corners([x - ro, -cradle_w / 2.0, base_t - 0.5], [x + ro, cradle_w / 2.0, zc]));
    cuts.push(cylinder([x, -rail_w, zc], "Y", ri, rail_w * 2.0));
    cuts.push(box_from_corners([x - pipe * 0.4, -rail_w, zc + ri * 0.4], [x + pipe * 0.4, rail_w, zc + ro + 1.0]));
    if k + 1 < n {
        cuts.push(cylinder([x + pitch / 2.0, 0, -1], "Z", 2.0, base_t + 2.0));
    }
}
fuse_all(shapes) - fuse_all(cuts)
