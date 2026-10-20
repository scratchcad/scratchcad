// Earplug carry case body: 60 x 28 x 18 mm capsule-ended box with two 23 mm pockets for foam plugs, 1.6 mm wall, 2 mm lid spigot step and a 4 mm lanyard eye
let length = 60.0; // [50.0, 80.0] Case length (mm)
let width = 28.0; // [24.0, 36.0] Case width (mm)
let height = 18.0; // [12.0, 25.0] Case height (mm)
let wall = 1.6; // [1.2, 2.5] Wall thickness (mm)
fn capsule(l, w, h) {
    box_centered(l - w, w, h).translate([0, 0, h / 2.0]) + cylinder([-(l - w) / 2.0, 0, 0], "Z", w / 2.0, h) + cylinder([(l - w) / 2.0, 0, 0], "Z", w / 2.0, h)
}
let body = capsule(length, width, height);
let step = capsule(length + 2.0, width + 2.0, 3.0).translate([0, 0, height - 2.0]) - capsule(length - wall, width - wall, 4.0).translate([0, 0, height - 3.0]);
let pr = width / 2.0 - wall - 0.6;
let pockets = [];
for s in [-1.0, 1.0] { pockets.push(cylinder([s * (length / 4.0 - 0.5), 0, wall], "Z", pr, height)); }
let eye = cylinder([length / 2.0 + 2.0, 0, height / 2.0 - 2.0], "Z", 4.5, 4.0) - cylinder([length / 2.0 + 3.0, 0, height / 2.0 - 3.0], "Z", 2.0, 6.0);
body - step - compound(pockets) + eye
