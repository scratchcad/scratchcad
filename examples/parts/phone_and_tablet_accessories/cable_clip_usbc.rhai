// Adhesive cable clip for 3 USB-C cables: 45 x 15 mm base 2 mm thick with three 4.2 mm snap channels on a 12 mm pitch, 3.2 mm entry gaps
let cable = 4.2; // [3.0, 6.0] Cable diameter (mm)
let count = 3; // [1, 6] Number of cables
const pitch = 12.0;
const t = 2.0;
let length = pitch * count.to_float() + 9.0;
let base = box_from_corners([0, 0, 0], [length, 15.0, t]);
let rings = [];
let cuts = [];
for i in 0..count {
    let x = 10.5 + pitch * i.to_float();
    rings.push(cylinder([x, 0, t + cable / 2.0], "Y", cable / 2.0 + 1.6, 15.0));
    cuts.push(cylinder([x, -1.0, t + cable / 2.0], "Y", cable / 2.0, 17.0));
    cuts.push(box_from_corners([x - cable * 0.38, -1.0, t + cable / 2.0], [x + cable * 0.38, 16.0, t + cable + 3.0]));
}
base + fuse_all(rings) - fuse_all(cuts)
