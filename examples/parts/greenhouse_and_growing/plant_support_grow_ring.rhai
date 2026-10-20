// Grow-through plant support ring: 300 mm peony ring with a 50 mm square grid of 3 mm ribs, 5 mm deep outer rim, and three 11 mm leg sockets for 10 mm stakes on 120 degree spacing
// # Ring
let diameter = 300.0; // [200.0, 450.0] Ring diameter (mm)
let rim = 6.0; // [4.0, 10.0] Rim width (mm)
let depth = 5.0; // [3.0, 8.0] Rim depth (mm)
// # Grid
let grid = 50.0; // [35.0, 80.0] Grid spacing (mm)
let rib = 3.0; // [2.0, 5.0] Rib width (mm)
let stake = 10.0; // [6.0, 14.0] Stake diameter (mm)
let r = diameter / 2.0;
let ring = cylinder(r, depth) - cylinder([0, 0, -1.0], "Z", r - rim, depth + 2.0);
let n = (r / grid).floor().to_int();
let ribs = [];
for i in -n..=n {
    let o = i.to_float() * grid;
    ribs.push(box_centered(diameter - rim, rib, depth * 0.6).translate([0, o, depth * 0.3]));
    ribs.push(box_centered(rib, diameter - rim, depth * 0.6).translate([o, 0, depth * 0.3]));
}
let grid_in = fuse_all(ribs) & cylinder([0, 0, -1.0], "Z", r - rim / 2.0, depth + 2.0);
let socks = [];
let holes = [];
for k in 0..3 {
    let a = (90.0 + k.to_float() * 120.0) * PI() / 180.0;
    let x = (r + stake / 2.0 + 1.0) * a.cos();
    let y = (r + stake / 2.0 + 1.0) * a.sin();
    socks.push(cylinder([x, y, 0], "Z", stake / 2.0 + 3.0, depth * 3.0));
    holes.push(cylinder([x, y, -1.0], "Z", stake / 2.0 + 0.5, depth * 3.0 + 2.0));
}
ring + grid_in + compound(socks) - compound(holes)
