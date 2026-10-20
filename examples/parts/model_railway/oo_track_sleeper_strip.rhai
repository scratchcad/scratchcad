// OO code 75 sleeper strip section: 10 sleepers 32 x 3.3 x 1.2 mm at 8.4 mm centers, chairs for 16.5 mm gauge
let n = 10; // [4, 30] Sleeper count
let pitch = 8.4; // [7.0, 10.0] Sleeper pitch (mm)
let gauge = 16.5; // [9.0, 32.0] Track gauge (mm)
let sleepers = [];
for i in 0..n {
    let x = i.to_float() * pitch;
    sleepers.push(box_from_corners([x - 1.65, -16.0, 0], [x + 1.65, 16.0, 1.2]));
    for side in [-1.0, 1.0] {
        let y = side * (gauge / 2.0 + 0.4);
        sleepers.push(box_from_corners([x - 1.3, y - 1.2, 1.19], [x + 1.3, y + 1.2, 2.0]) - box_from_corners([x - 2.0, y - 0.4, 1.6], [x + 2.0, y + 0.4, 3.0]));
    }
}
let web = box_from_corners([-1.0, -0.5, 0], [(n - 1).to_float() * pitch + 1.0, 0.5, 0.4]);
fuse_all(sleepers) + web
