// M14x1.25 spark plug, 19 mm reach: 16 mm hex, ribbed insulator, terminal nut, 0.8 mm gap to an L ground electrode
let reach = 19.0; // [12.7, 26.5] Thread reach (mm)
const z0 = 1.5;
let zt = z0 + reach;
let p = [[0, 0, 0], [1.25, 0, 0], [1.25, 0, z0], [6.3, 0, z0], [7.0, 0, z0 + 0.7], [7.0, 0, zt], [9.6, 0, zt], [9.6, 0, zt + 2.0],
         [8.0, 0, zt + 2.0], [8.0, 0, zt + 16.0], [8.5, 0, zt + 16.0], [8.5, 0, zt + 18.0], [6.5, 0, zt + 18.0], [6.5, 0, zt + 24.0], [5.2, 0, zt + 26.0]];
let z = zt + 26.0;
for i in 0..4 { p += [[5.2, 0, z + 2.0], [5.6, 0, z + 2.5], [5.6, 0, z + 4.0], [5.2, 0, z + 4.5]]; z += 4.5; }
p += [[5.2, 0, z + 3.0], [2.0, 0, z + 4.0], [2.0, 0, z + 8.0], [4.0, 0, z + 8.0], [4.0, 0, z + 12.5], [3.5, 0, z + 13.0], [0, 0, z + 13.0]];
let body = polygon(p).to_face().revolve("Z", 360);
let rc = 16.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(hp).to_face().extrude(12.0).translate([0, 0, zt + 3.0]);
let ground = box_from_corners([-1.3, -1.3, -2.1], [7.0, 1.3, -0.8]) + box_from_corners([5.6, -1.3, -2.1], [7.0, 1.3, z0 + 0.1]);
fuse_all([body, hex, ground])
