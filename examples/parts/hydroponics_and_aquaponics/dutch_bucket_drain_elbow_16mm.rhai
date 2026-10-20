// Dutch (Bato) bucket drain elbow: a 16 mm barbed stem 20 mm long that pushes down through the bucket floor grommet, a 20 mm round elbow joint, and a 16 mm barbed outlet 25 mm long for 13 mm ID drain hose, 10 mm bore throughout
let barb_d = 16.0; // [12.0, 22.0] Barb diameter (mm)
let stem_len = 20.0; // [12.0, 35.0] Stem length (mm)
let outlet_len = 25.0; // [15.0, 40.0] Outlet length (mm)
let bore_d = 10.0; // [6.0, 14.0] Bore diameter (mm)
let rb = barb_d / 2.0;
let br = min(bore_d / 2.0, rb - 2.5);
let jr = rb + 2.0;
let barbs = |len| {
    let pts = [[br, 0, 0], [rb - 0.8, 0, 0], [rb, 0, len * 0.25], [rb - 0.8, 0, len * 0.25], [rb, 0, len * 0.55], [rb - 0.8, 0, len * 0.55], [rb - 0.8, 0, len], [br, 0, len]];
    face(polygon(pts)).revolve("Z", 360.0)
};
let ls = stem_len + jr;
let lo = outlet_len + jr;
let stem = barbs.call(ls).translate([0, 0, -ls]);
let outlet = barbs.call(lo).rotate_y(-90.0).translate([lo, 0, 0]);
let joint = sphere(jr);
let body = fuse_all([stem, outlet, joint]);
body - fuse_all([cylinder([0, 0, -ls - 1.0], "Z", br, ls + 1.0), cylinder([0, 0, 0], "X", br, lo + 1.0)])
