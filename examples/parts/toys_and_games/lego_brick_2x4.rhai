// LEGO-compatible 2 x 4 brick: 31.8 x 15.8 x 9.6 mm, 1.5 mm walls, eight 4.8 mm studs 1.7 mm tall, three 6.51 mm tubes underneath
let nx = 4; // [1, 10] Studs long
let ny = 2; // [1, 4] Studs wide
const p = 8.0;
let w = nx.to_float() * p - 0.2;
let d = ny.to_float() * p - 0.2;
let brick = box_from_corners([0, 0, 0], [w, d, 9.6]) - box_from_corners([1.5, 1.5, -1], [w - 1.5, d - 1.5, 8.6]);
let studs = [];
for i in 0..nx { for j in 0..ny { studs.push(cylinder([p / 2.0 - 0.1 + i.to_float() * p, p / 2.0 - 0.1 + j.to_float() * p, 9.59], "Z", 2.4, 1.71)); } }
let tubes = [];
if ny > 1 { for i in 1..nx { for j in 1..ny { tubes.push(cylinder([i.to_float() * p - 0.1, j.to_float() * p - 0.1, 0], "Z", 3.255, 8.7) - cylinder([i.to_float() * p - 0.1, j.to_float() * p - 0.1, -1], "Z", 2.4, 11.0)); } } }
fuse_all([brick] + studs + tubes)
