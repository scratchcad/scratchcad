// 1-1/2 in drain cleanout plug: 48 mm male thread (11.5 TPI, 2.2 mm pitch) 16 mm long, 56 mm flange 3 mm, 22 mm square drive nut 12 mm tall, hollow underside
let thread_d = 48.0; // [40.0, 62.0] Thread major diameter (mm)
let thread_l = 16.0; // [10.0, 24.0] Thread length (mm)
let flange_d = 56.0; // [46.0, 72.0] Flange diameter (mm)
let nut = 22.0; // [16.0, 30.0] Square nut size (mm)
let nut_h = 12.0; // [8.0, 16.0] Nut height (mm)
const pitch = 2.2;
let rM = thread_d / 2.0;
let rm = rM - 1.2;
let pts = [[rm - 3.0, 0, 0], [rm - 0.5, 0, 0], [rm, 0, 0.5]];
let n = ((thread_l - 1.5) / pitch).floor().to_int();
for i in 0..n {
    let z0 = 0.5 + i.to_float() * pitch;
    pts.push([rM, 0, z0 + 0.35 * pitch]);
    pts.push([rM, 0, z0 + 0.65 * pitch]);
    pts.push([rm, 0, z0 + pitch]);
}
pts.push([rm, 0, thread_l]);
pts.push([flange_d / 2.0, 0, thread_l]);
pts.push([flange_d / 2.0, 0, thread_l + 3.0]);
pts.push([0, 0, thread_l + 3.0]);
pts.push([0, 0, thread_l - 3.0]);
pts.push([rm - 3.0, 0, thread_l - 3.0]);
let body = polygon(pts).to_face().revolve("Z", 360);
let sq = box_centered(nut, nut, nut_h + 1.0).translate([0, 0, thread_l + 2.5 + nut_h / 2.0]);
body + sq.chamfer(1.0, sq.edges(">Z"))
