// Sheep shearing comb guard: 76 mm wide comb, 13 teeth 3 mm wide, 30 mm long, 4 mm thick, 2 slots for fixing
let width = 76.0; // [60.0, 95.0] Comb width (mm)
let teeth = 13; // [9, 20] Tooth count
let length = 30.0; // [20.0, 45.0] Tooth length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, 25.0, t]);
let tooth = [];
let pitch = width / teeth.to_float();
for i in 0..teeth {
    let x = -width / 2.0 + (i.to_float() + 0.5) * pitch;
    tooth.push(polygon([[x - 1.5, 0.01], [x + 1.5, 0.01], [x + 0.6, -length], [x - 0.6, -length]]).to_face().extrude([0, 0, t]));
}
back + fuse_all(tooth) - box_from_corners([-16.0, 8.0, -1], [-10.0, 20.0, t + 1.0]) - box_from_corners([10.0, 8.0, -1], [16.0, 20.0, t + 1.0])
