// Hay rack for small pets: 120 mm wide wall rack 80 mm tall, 50 mm deep at the top tapering to 10 mm at the bottom, 3 mm bars on 10 mm centres and a 6 mm top rim
let width = 120.0; // [80.0, 200.0] Rack width (mm)
let height = 80.0; // [60.0, 120.0] Rack height (mm)
const t = 3.0;
let back = box_from_corners([0, 0, 0], [width, t, height]);
let sides = [];
for x in [0.0, width - t] { sides.push(face(polygon([[x, 0, 0], [x, 10.0, 0], [x, 50.0, height], [x, 0, height]])).extrude([t, 0, 0])); }
let rim = box_from_corners([0, 44.0, height - 6.0], [width, 50.0, height]);
let bars = [];
let n = ((width - 2.0 * t) / 10.0).to_int();
for i in 1..n { let x = t + i.to_float() * 10.0; bars.push(face(polygon([[x, 10.0 - t, 0], [x, 10.0, 0], [x, 50.0, height], [x, 50.0 - t, height]])).extrude([t, 0, 0])); }
let floor_ = box_from_corners([0, 0, 0], [width, 10.0, t]);
back + fuse_all(sides) + rim + fuse_all(bars) + floor_
