// Belt tee holder: 50 x 40 mm clip for a 40 mm belt, 2.5 mm thick, with four 5 mm tee sockets 15 mm deep in a 12 mm block along the bottom
let belt = 40.0; // [30.0, 50.0] Belt width (mm)
let tees = 4; // [2, 6] Number of tee sockets
const t = 2.5;
let w = 10.0 * tees.to_float() + 10.0;
let back = box_from_corners([0, 0, 0], [w, t, belt + 10.0]);
let loop_ = box_from_corners([0, 0, belt + 10.0 - 0.01], [w, 8.0, belt + 10.0 + t]) + box_from_corners([0, 8.0 - t, belt * 0.5], [w, 8.0, belt + 10.0 + t]);
let block = box_from_corners([0, -12.0, 0], [w, t + 0.01, 15.0]);
let holes = [];
for i in 0..tees { holes.push(cylinder([10.0 + 10.0 * i.to_float(), -6.0, 2.0], "Z", 2.6, 15.0)); }
back + loop_ + block - fuse_all(holes)
