// Outer CV joint boot: 7 convolutions, 26 mm shaft collar, 80 mm housing collar, 2.5 mm wall, 100 mm long
let folds = 7; // [4, 9] Convolutions
let small = 13.0; // [10.0, 16.0] Shaft collar outer radius (mm)
let large = 40.0; // [32.0, 46.0] Housing collar outer radius (mm)
let wall = 2.5; // [1.5, 3.5] Wall thickness (mm)
let pitch = 70.0 / folds.to_float();
let outer = [[small, 0, 0.0], [small, 0, 15.0]];
for k in 0..folds {
    let rp = 20.0 + (large + 4.0 - 20.0) * k.to_float() / (folds - 1).to_float();
    outer.push([rp, 0, 15.0 + (k.to_float() + 0.5) * pitch]);
    if k < folds - 1 { outer.push([rp - 7.0, 0, 15.0 + (k.to_float() + 1.0) * pitch]); }
}
outer += [[large, 0, 85.0], [large, 0, 100.0]];
let inner = [];
for p in outer { inner.push([p[0] - wall, 0, p[2]]); }
inner.reverse();
polygon(outer + inner).to_face().revolve("Z", 360)
