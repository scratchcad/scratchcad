// 3-station valve manifold: 60 x 30 x 20 mm, G1/8 P port 8.5 mm drill through, 3 outlet ports, 4 x M4 valve holes per station
let stations = 3; // [2, 8] Station count
let pitch = 20.0; // [16.0, 30.0] Station pitch (mm)
let width = 30.0; // [24.0, 40.0] Width (mm)
let height = 20.0; // [16.0, 30.0] Height (mm)
let length = stations.to_float() * pitch;
let block = box_from_corners([0, 0, 0], [length, width, height]);
let cuts = [cylinder([-1, width / 2.0, height / 2.0], "X", 4.25, length + 2.0)];
for i in 0..stations {
    let x = (i.to_float() + 0.5) * pitch;
    cuts.push(cylinder([x, width / 2.0, height / 2.0], "Z", 2.5, height));
    cuts.push(cylinder([x, -1, height * 0.3], "Y", 4.25, width / 2.0));
    for p in [[-6.0, -10.0], [6.0, -10.0], [-6.0, 10.0], [6.0, 10.0]] { cuts.push(cylinder([x + p[0] * 0.8, width / 2.0 + p[1], height - 8.0], "Z", 1.65, 9.0)); }
}
block - fuse_all(cuts)
