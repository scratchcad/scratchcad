// AC drip tray condensate drain spout for 16 mm ID hose: 24 mm hex flange 5 mm, 20 mm threaded-style stub 12 mm long with 3 grooves, 14 mm shank with 3 barbs to 17.5 mm, 10 mm bore
let hose_id = 16.0; // [10.0, 22.0] Hose inside diameter (mm)
let barb_count = 3; // [1, 5] Number of hose barbs
let stub_l = 12.0; // [8.0, 20.0] Tray stub length (mm)
let bore = 10.0; // [6.0, 12.0] Bore diameter (mm)
const barb_l = 6.0;
const hex_t = 5.0;
let rs = hose_id / 2.0 - 1.0;
let rbarb = hose_id / 2.0 + 0.75;
let rbore = min(bore / 2.0, rs - 1.5);
let hex_af = hose_id + 8.0;
let hex_r = hex_af / 2.0 / (30.0 * PI() / 180.0).cos();
let pts = [];
for k in 0..6 {
    let a = (k.to_float() * 60.0) * PI() / 180.0;
    pts.push([hex_r * a.cos(), hex_r * a.sin(), 0.0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_t]);
let stub_r = hose_id / 2.0 + 2.0;
let stub = cylinder([0, 0, -stub_l], "Z", stub_r, stub_l + 0.5);
let grooves = [];
for i in 0..3 {
    grooves.push(cylinder([0, 0, -stub_l + 2.0 + i.to_float() * (stub_l - 4.0) / 3.0], "Z", stub_r + 1.0, 1.0) - cylinder([0, 0, -stub_l], "Z", stub_r - 0.6, stub_l));
}
let shank_l = barb_count.to_float() * barb_l + 4.0;
let shank = cylinder([0, 0, hex_t - 0.5], "Z", rs, shank_l + 0.5);
let barbs = [];
for i in 0..barb_count {
    barbs.push(cone(rbarb, rs - 0.5, barb_l).translate([0, 0, hex_t + 2.0 + i.to_float() * barb_l]));
}
let spout = fuse_all([hex, stub, shank] + barbs) - compound(grooves);
spout - cylinder([0, 0, -stub_l - 1.0], "Z", rbore, stub_l + hex_t + shank_l + 2.0)
