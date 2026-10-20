// Bone guitar nut: 43 x 6 x 9 mm blank with a radiused top, six string slots spaced 35 mm E to E, slots angled toward the headstock
let w = 43.0; // [38.0, 48.0] Width (mm)
let span = 35.0; // [30.0, 40.0] Outer string spacing (mm)
let nut = box_centered(w, 6.0, 9.0).translate([0, 0, 4.5]) & cylinder([0, -5.0, -300.0 + 9.0], "Y", 300.0, 10.0);
let gauges = [1.17, 0.91, 0.66, 0.43, 0.33, 0.25];
let slots = [];
for k in 0..6 {
    let x = -span / 2.0 + k.to_float() * span / 5.0;
    slots.push(box_centered(gauges[k] + 0.1, 8.0, 3.0).rotate_x(-6.0).translate([x, 0, 8.4]));
}
nut - fuse_all(slots)
