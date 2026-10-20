// F-clamp wall rack: 300 x 60 x 10 mm back plate, 5 fingers 15 x 12 mm reaching 80 mm with 6 mm up-turned tips, gaps for the clamp bars, a 4.5 mm screw hole in each gap
let length = 300.0; // [180.0, 500.0] Rack length (mm)
let fingers = 5; // [3, 9] Number of fingers
let reach = 80.0; // [50.0, 120.0] Finger reach (mm)
let finger_w = 15.0; // [10.0, 25.0] Finger width (mm)
let tip = 6.0; // [3.0, 12.0] Tip height (mm)
let plate = box_from_corners([0, 0, 0], [length, 10.0, 60.0]);
let p = plate.fillet(5.0, plate.edges("|Y"));
let pitch = (length - finger_w) / (fingers - 1).to_float();
let fs = [p];
for i in 0..fingers {
    let x = i.to_float() * pitch;
    fs.push(box_from_corners([x, 9.5, 10.0], [x + finger_w, 10.0 + reach, 22.0]));
    fs.push(box_from_corners([x, reach, 21.5], [x + finger_w, 10.0 + reach, 22.0 + tip]));
}
let holes = [];
for k in 0..(fingers - 1) {
    holes.push(cylinder([(k.to_float() + 0.5) * pitch + finger_w / 2.0, -1, 42.0], "Y", 2.25, 12.0));
}
fuse_all(fs) - compound(holes)
