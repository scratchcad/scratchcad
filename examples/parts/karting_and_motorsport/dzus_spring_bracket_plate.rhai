// Dzus quarter-turn fastener spring bracket: 50 x 16 x 2 mm plate with 2 mm rounded corners, two 3.3 mm rivet holes 36 mm apart, a 10 mm centre clearance hole, and two 8 mm tall ears 2 mm thick at 26 mm spacing with 2.5 mm holes for the spring wire
let length = 50.0; // [40.0, 70.0] Plate length (mm)
let width = 16.0; // [12.0, 25.0] Plate width (mm)
let ear_h = 8.0; // [5.0, 14.0] Ear height (mm)
let ear_spacing = 26.0; // [18.0, 32.0] Ear spacing (mm)
const t = 2.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(2.0, plate.edges("|Z"));
let ears = [];
for s in [-1.0, 1.0] {
    let x = s * (ear_spacing / 2.0 + t / 2.0);
    let ear = box_centered(t, width - 4.0, ear_h).translate([x, 0, ear_h / 2.0 + t - 0.5]);
    ears.push(ear.fillet(min(3.0, ear_h / 2.0), ear.edges("|X and >Z")));
}
let body = plate + fuse_all(ears);
let sp = min(36.0, length - 8.0);
let cuts = [cylinder([0, 0, -1.0], "Z", 5.0, t + 2.0), cylinder([-length, 0, t + ear_h - 3.0], "X", 1.25, 2.0 * length)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * sp / 2.0, 0, -1.0], "Z", 1.65, t + 2.0));
}
body - fuse_all(cuts)
