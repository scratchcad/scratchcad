// 8-ball rack corner piece: 60 degree corner of a 25 x 12 mm frame for 57 mm balls, 50 mm legs, radiused inside
let width = 25.0; // [18.0, 35.0] Frame height (mm)
let t = 12.0; // [8.0, 18.0] Frame thickness (mm)
let leg = 50.0; // [30.0, 80.0] Leg length (mm)
let a = box_from_corners([0, 0, 0], [leg, t, width]);
let b = box_from_corners([0, 0, 0], [leg, t, width]).rotate_z(60.0);
let c = a + b;
c & cylinder([0, 0, -1], "Z", leg, width + 2.0)
