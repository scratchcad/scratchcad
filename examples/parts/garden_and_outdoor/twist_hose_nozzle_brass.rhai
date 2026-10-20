// 4 in brass twist hose nozzle: 3/4 GHT female inlet 30 mm, 26 mm knurled sleeve, tapering to a 12 mm tip with a 2.5 mm jet
let length = 100.0; // [80.0, 130.0] Overall length (mm)
let inlet_diameter = 30.0; // [28.0, 36.0] Inlet diameter (mm)
let sleeve_diameter = 26.0; // [20.0, 32.0] Grip sleeve diameter (mm)
let tip_diameter = 12.0; // [8.0, 16.0] Tip diameter (mm)
let jet_diameter = 2.5; // [1.0, 5.0] Jet orifice diameter (mm)
let ri = inlet_diameter / 2.0;
let rs = sleeve_diameter / 2.0;
let rt = tip_diameter / 2.0;
let rj = jet_diameter / 2.0;
let outer = [[rj, length], [rj, length - 2.0], [rt - 2.0, length - 6.0], [rj + 1.0, length - 2.0]];
let p = [[0, 0], [ri, 0], [ri, 18.0], [rs - 1.0, 21.0], [rs, 24.0], [rs, 62.0], [rt + 1.0, length - 8.0], [rt, length - 2.0],
         [rt - 1.5, length], [rj, length], [rj, length - 4.0], [rs - 4.0, 60.0], [rs - 4.0, 24.0], [11.5, 22.0], [11.5, 14.0], [0, 14.0]];
let pts = [];
for q in p { pts.push([q[0], 0, q[1]]); }
let body = polygon(pts).to_face().revolve("Z", 360);
// inlet bore with a simple thread relief and a washer seat
body -= cylinder([0, 0, -1], "Z", 12.6, 15.0);
// grip knurl
let grooves = [];
for i in 0..24 {
    grooves.push(cylinder([rs + 0.3, 0, 27.0], "Z", 0.9, 32.0).rotate_z(i.to_float() * 15.0));
}
body - compound(grooves)
