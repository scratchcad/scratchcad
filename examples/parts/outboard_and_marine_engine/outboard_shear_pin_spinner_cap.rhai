// Small outboard shear pin spinner cap: 40 mm cone 30 mm long over the end of a 12 mm prop shaft, 14 mm skirt bore 18 mm deep with two 4.5 x 8 mm slots that drop over the 4 mm shear pin, and a 3.2 mm split pin hole across the shaft 10 mm from the base
let base_d = 40.0; // [30.0, 60.0] Cap base diameter (mm)
let length = 30.0; // [24.0, 50.0] Cap length (mm)
let shaft_d = 12.0; // [10.0, 16.0] Prop shaft diameter (mm)
const pin_d = 4.0;
let rb = base_d / 2.0;
const rt = 4.0;
const skirt = 18.0;
let profile = polygon([[0, 0, 0], [rb, 0, 0], [rb, 0, 6.0], [rt + 2.0, 0, length - 1.0], [rt, 0, length], [0, 0, length]]);
let cap = face(profile).revolve("Z", 360.0);
let cuts = [
    cylinder([0, 0, -1.0], "Z", shaft_d / 2.0 + 1.0, skirt + 1.0),
    box_from_corners([-(pin_d + 0.5) / 2.0, -rb - 1.0, -1.0], [(pin_d + 0.5) / 2.0, rb + 1.0, 8.0]),
    cylinder([-rb, 0, 10.0], "X", 1.6, 2.0 * rb)
];
cap - fuse_all(cuts)
