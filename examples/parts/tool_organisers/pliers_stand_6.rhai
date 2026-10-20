// Pliers stand: 6 upright slots 14 mm wide between 3 mm fins 45 mm tall so pliers stand handles-down, joined by a back spine on a 60 mm deep base 6 mm thick
let count = 6; // [3, 10] Number of pliers
let slot = 14.0; // [10.0, 20.0] Slot width (mm)
const wall = 3.0;
let pitch = slot + wall;
let length = pitch * count.to_float() + 20.0;
let base = box_from_corners([0, 0, 0], [length, 60.0, 6.0]);
let fins = [];
for i in 0..=count {
    let x = 10.0 + pitch * i.to_float() - wall / 2.0;
    fins.push(box_from_corners([x, 10.0, 5.99], [x + wall, 50.0, 51.0]));
}
let spine = box_from_corners([10.0 - wall / 2.0, 47.0, 5.99], [10.0 + pitch * count.to_float() + wall / 2.0, 50.0, 51.0]);
base + fuse_all(fins) + spine
