// Hand pipe bender former for 15 mm copper: 55 mm centre-line bend radius, 18 mm thick disc with a 15.3 mm wide flat-bottom groove 7.5 mm deep (chamfered flanks), 12.2 mm pivot bore, 3 lightening holes
let pipe = 15.0; // [8.0, 22.0] Pipe size (mm)
let bend_radius = 55.0; // [35.0, 90.0] Centre-line bend radius (mm)
let thick = 18.0; // [12.0, 28.0] Former thickness (mm)
let pivot = 12.2; // [8.0, 16.0] Pivot bore (mm)
let lightening = 3; // [0, 6] Number of lightening holes
let gw = pipe + 0.3;
let t = max(thick, gw + 3.0);
let rg = bend_radius;
let rbot = rg - pipe / 2.0;
let rout = rg + 1.0;
let z0 = (t - gw) / 2.0;
let c = gw * 0.2;
let pts = [[pivot / 2.0, 0, 0], [rout, 0, 0], [rout, 0, z0], [rbot + c, 0, z0], [rbot, 0, z0 + c], [rbot, 0, z0 + gw - c], [rbot + c, 0, z0 + gw], [rout, 0, z0 + gw], [rout, 0, t], [pivot / 2.0, 0, t]];
let former = polygon(pts).to_face().revolve("Z", 360);
let holes = [];
let rh = (pivot / 2.0 + rbot) / 2.0;
let hr = (rbot - pivot / 2.0) * 0.28;
for k in 0..lightening {
    let a = k.to_float() * 2.0 * PI() / lightening.to_float();
    holes.push(cylinder([rh * a.cos(), rh * a.sin(), -1], "Z", hr, t + 2.0));
}
former - compound(holes)
