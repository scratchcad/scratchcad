// 1/4 inch hex bit holder strip: 12 hex sockets 6.5 mm across flats, 10 mm deep on a 12 mm pitch in a 150 x 16 x 14 mm bar with a 6 mm magnet groove underneath
let bits = 12; // [4, 20] Number of bit sockets
let depth = 10.0; // [6.0, 12.0] Socket depth (mm)
const pitch = 12.0;
const h = 14.0;
fn hexp(af, x, y, z, d) {
    let r = af / 2.0 / cos(PI() / 6.0);
    let p = [];
    for i in 0..6 { let a = (30.0 + 60.0 * i.to_float()) * PI() / 180.0; p.push([x + r * cos(a), y + r * sin(a), z]); }
    face(polygon(p)).extrude([0, 0, d])
}
let length = pitch * bits.to_float() + 6.0;
let bar = box_from_corners([0, 0, 0], [length, 16.0, h]);
let bar = bar.chamfer(1.0, bar.edges(">Z"));
let cuts = [box_from_corners([-1.0, 5.0, -1.0], [length + 1.0, 11.0, 2.5])];
for i in 0..bits { cuts.push(hexp(6.5, 3.0 + pitch * (i.to_float() + 0.5), 8.0, h - depth, depth + 1.0)); }
bar - fuse_all(cuts)
