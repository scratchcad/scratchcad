// 1:76 locomotive water tank on tower: 40 x 30 x 18 mm riveted tank with a swinging bag arm stub
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let tank = box_from_corners([-20.0, -15.0, 30.0], [20.0, 15.0, 48.0]) - box_from_corners([-19.0, -14.0, 31.0], [19.0, 14.0, 49.0]);
let ribs = [];
for k in 0..5 { ribs.push(box_from_corners([-20.3, -15.3, 30.0 + k.to_float() * 4.0], [20.3, 15.3, 30.5 + k.to_float() * 4.0])); }
let legs = [];
for x in [-17.0, 17.0] { for y in [-12.0, 12.0] { legs.push(box_from_corners([x - 1.0, y - 1.0, 0], [x + 1.0, y + 1.0, 30.01])); } }
let pipe = cylinder([0, -27.0, 34.0], "Y", 1.5, 12.01);
(tank + fuse_all(ribs) + fuse_all(legs) + pipe).scale(s)
