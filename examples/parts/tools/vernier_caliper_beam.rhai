// 150 mm vernier caliper: 16 x 3.5 mm beam 220 mm long with fixed outside and inside jaws and a depth rod groove; separate slider with jaws
let range = 150.0; // [100.0, 300.0] Measuring range (mm)
let L = range + 70.0;
let beam = box_from_corners([0, 0, 0], [L, 16.0, 3.5]) - box_from_corners([10.0, 7.0, -1], [L + 1.0, 9.0, 1.5]);
let jaw = polygon([[0, 0], [12, 0], [12, -35], [6, -42], [0, -42]]).to_face().extrude(3.5);
let inner_jaw = polygon([[0, 16], [12, 16], [12, 28], [6, 32], [0, 28]]).to_face().extrude(3.5);
let n = (range / 10.0).to_int();
for k in 0..n { beam -= box_centered(0.3, 4.0, 1.0).translate([16.0 + k.to_float() * 10.0, 14.0, 3.5]); }
let slider = box_from_corners([30.0, -2.0, -1.5], [75.0, 18.0, 5.0]) - box_from_corners([29.0, -0.1, -0.1], [76.0, 16.1, 3.6]);
slider += polygon([[30, -2], [42, -2], [42, -42], [36, -42], [30, -35]]).to_face().extrude(3.5);
slider += polygon([[30, 18], [42, 18], [42, 28], [36, 32], [30, 28]]).to_face().extrude(3.5);
compound([fuse_all([beam, jaw, inner_jaw]), slider + box_from_corners([60.0, 18.0, 1.0], [68.0, 22.0, 4.0])])
