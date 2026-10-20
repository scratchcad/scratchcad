// Busbar support insulator SM40: 40 mm tall, 32 mm body with three 2 mm creepage sheds out to 36 mm, 3 mm chamfered ends, M8 tapped bores (6.8 mm core) 12 mm deep top and bottom
let height = 40.0; // [25.0, 76.0] Insulator height (mm)
let body_d = 32.0; // [25.0, 45.0] Body diameter (mm)
let thread_d = 8.0; // [5.0, 10.0] Thread size (mm)
let bore_depth = 12.0; // [8.0, 12.0] Thread depth (mm)
const sheds = 3;
let r = body_d / 2.0;
let rs = r + 2.0;
let core = (thread_d * 0.85) / 2.0;
let pts = [[0.0, 0, 0.0], [r - 3.0, 0, 0.0], [r, 0, 3.0]];
let span = height - 6.0;
for i in 0..sheds {
    let zc = 3.0 + span * (i.to_float() + 1.0) / (sheds.to_float() + 1.0);
    pts.push([r, 0, zc - 2.5]);
    pts.push([rs, 0, zc - 1.0]);
    pts.push([rs, 0, zc + 1.0]);
    pts.push([r, 0, zc + 2.5]);
}
pts.push([r, 0, height - 3.0]);
pts.push([r - 3.0, 0, height]);
pts.push([0.0, 0, height]);
let body = face(polygon(pts)).revolve("Z", 360.0);
body - cylinder([0, 0, -1.0], "Z", core, bore_depth + 1.0) - cylinder([0, 0, height - bore_depth], "Z", core, bore_depth + 1.0)
