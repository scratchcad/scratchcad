// Reservoir water level sight tube fitting: a 1/2 inch BSP style shank (20.9 mm, 14 TPI ring ridges) 18 mm long through the tank wall, a 28 mm flange 4 mm thick, a 16 mm round elbow outside and a 3/8 inch barb (10.5 mm crest) 22 mm tall pointing up for the clear sight tube, 6 mm bore throughout
let shank_len = 18.0; // [10.0, 30.0] Shank length (mm)
let flange_d = 28.0; // [24.0, 40.0] Flange diameter (mm)
let barb_len = 22.0; // [14.0, 35.0] Barb length (mm)
let tube_id = 9.5; // [6.0, 12.7] Sight tube inside diameter (mm)
const bore = 3.0;
const ft = 4.0;
const tr = 10.45;
const pitch = 1.814;
const jr = 8.0;
let crest = tube_id / 2.0 + 0.5;
let root = tube_id / 2.0 - 0.2;
let bb = min(bore, root - 0.8);
let pts = [[bore, 0, 0], [tr - 0.5, 0, 0], [tr, 0, 0.5]];
let n = ((shank_len - 2.0) / pitch).floor().to_int();
for i in 0..n {
    pts.push([tr - 0.55, 0, 0.5 + pitch * (i.to_float() + 0.5)]);
    pts.push([tr, 0, 0.5 + pitch * (i.to_float() + 1.0)]);
}
pts.push([tr, 0, shank_len]);
pts.push([max(flange_d / 2.0, tr + 3.0), 0, shank_len]);
pts.push([max(flange_d / 2.0, tr + 3.0), 0, shank_len + ft]);
pts.push([jr - 1.0, 0, shank_len + ft]);
pts.push([jr - 1.0, 0, shank_len + ft + jr]);
pts.push([bore, 0, shank_len + ft + jr]);
let shank = face(polygon(pts)).revolve("Z", 360.0);
let zc = shank_len + ft + jr;
let joint = sphere([0, 0, zc], jr);
let bl = barb_len + jr;
let barb = face(polygon([[bb, 0, 0], [root - 0.3, 0, 0], [crest, 0, bl * 0.2], [root, 0, bl * 0.2], [crest, 0, bl * 0.45], [root, 0, bl * 0.45], [jr - 1.0, 0, bl], [bb, 0, bl]])).revolve("Z", 360.0);
let barb = barb.rotate_y(-90.0).translate([bl, 0, zc]);
let body = fuse_all([shank, joint, barb]);
let cuts = [cylinder([0, 0, -1.0], "Z", bore, zc + 1.0), cylinder([0, 0, zc], "X", bb, bl + 1.0)];
(body - fuse_all(cuts)).rotate_y(-90.0)
