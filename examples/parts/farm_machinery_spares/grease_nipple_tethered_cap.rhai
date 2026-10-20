// Tethered dust cap for M10 grease nipples on farm machinery: 10 mm cap 11 mm tall with a 6.8 mm bore 9 mm deep and a 0.4 mm snap bead for the 6.5 mm nipple head, joined by a 2 x 1.2 mm strap 18 mm long to a 1.5 mm thick retaining ring with an 11.5 mm hole that sits under the nipple's 11 mm hex
let head_d = 6.8; // [5.5, 8.5] Nipple head bore (mm)
let cap_h = 11.0; // [8.0, 15.0] Cap height (mm)
let strap_len = 18.0; // [10.0, 30.0] Strap length (mm)
let ring_hole = 11.5; // [9.0, 15.0] Retaining ring hole (mm)
const wall = 1.6;
const bead = 0.4;
const strap_w = 2.0;
const strap_t = 1.2;
const ring_t = 1.5;
const ring_w = 2.5;
let rb = head_d / 2.0;
let ro = rb + wall;
let depth = cap_h - 2.0;
let cap = polygon([
    [rb - bead, 0, 0], [ro, 0, 0], [ro, 0, cap_h], [0, 0, cap_h], [0, 0, depth], [rb, 0, depth], [rb, 0, 1.4], [rb - bead, 0, 0.8],
]).to_face().revolve("Z", 360.0);
let rr = ring_hole / 2.0;
let rro = rr + ring_w;
let cx = ro + strap_len + rro;
let ring = cylinder([cx, 0, 0], "Z", rro, ring_t) - cylinder([cx, 0, -1.0], "Z", rr, ring_t + 2.0);
let strap = box_from_corners([ro - 0.5, -strap_w / 2.0, 0], [cx - rr - 0.5, strap_w / 2.0, strap_t]);
fuse_all([cap, strap, ring])
