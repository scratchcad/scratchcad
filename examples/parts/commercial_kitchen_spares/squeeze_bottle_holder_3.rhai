// Line station squeeze bottle holder: 3 holes for 60 mm (24 oz) sauce bottles with 15 mm between them (75 mm pitch) in a 230 x 85 mm plate 5 mm thick, 15 mm down-turned front and back lips to sit across a GN well
let bottles = 3; // [2, 6] Number of bottles
let bottle_d = 60.0; // [45.0, 75.0] Bottle diameter (mm)
let gap = 15.0; // [8.0, 30.0] Gap between bottles (mm)
const t = 5.0;
const lip = 15.0;
let pitch = bottle_d + gap;
let w = bottle_d + 25.0;
let len = pitch * bottles.to_float() + 5.0;
let plate = fuse_all([
    box_from_corners([0, 0, 0], [len, w, t]),
    box_from_corners([0, 0, -lip], [len, t, t]),
    box_from_corners([0, w - t, -lip], [len, w, t]),
]);
let holes = [];
for i in 0..bottles {
    holes.push(cylinder([pitch * (i.to_float() + 0.5) + 2.5, w / 2.0, -1.0], "Z", bottle_d / 2.0 + 1.0, t + 2.0));
}
plate - compound(holes)
