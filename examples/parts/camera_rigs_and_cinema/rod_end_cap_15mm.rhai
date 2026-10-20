// Push-in end cap for 15 mm LWS rods with a 10.5 mm bore: 17 mm head 6 mm tall with a 1.5 mm chamfer, 10.3 mm plug 10 mm long with three 0.3 mm grip ribs and a 0.6 mm lead-in chamfer
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let bore = 10.5; // [8.0, 13.0] Rod bore (mm)
let plug_len = 10.0; // [8.0, 16.0] Plug length (mm)
const head_h = 6.0;
let rh = rod_d / 2.0 + 1.0;
let rp = min(bore / 2.0 - 0.1, rod_d / 2.0 - 1.5);
let pts = [[0.0, 0, -plug_len], [rp - 0.6, 0, -plug_len], [rp, 0, -plug_len + 0.6]];
for k in 0..3 {
    let z = -plug_len + 2.0 + k.to_float() * (plug_len - 3.0) / 3.0;
    pts.push([rp, 0, z]);
    pts.push([rp + 0.3, 0, z + 0.5]);
    pts.push([rp, 0, z + 1.0]);
}
pts.push([rp, 0, 0.0]);
pts.push([rh, 0, 0.0]);
pts.push([rh, 0, head_h - 1.5]);
pts.push([rh - 1.5, 0, head_h]);
pts.push([0.0, 0, head_h]);
face(polygon(pts)).revolve("Z", 360.0)
