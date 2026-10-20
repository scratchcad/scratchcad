// Janitor closet mop and broom hanger rail: 400 mm wall rail 6 mm thick and 55 mm tall with five jaws 30 mm deep standing out 45 mm along its top, each with a 22 mm handle hole opening through an 18 mm mouth and 1.5 mm flex slots beside it, and four 5 mm countersunk screw holes below the jaws
let length = 400.0; // [200.0, 700.0] Rail length (mm)
let jaws = 5; // [2, 8] Number of jaws
let handle_d = 22.0; // [18.0, 32.0] Handle diameter (mm)
let jaw_depth = 30.0; // [20.0, 45.0] Jaw thickness (mm)
const t = 6.0;
const out = 45.0;
let h = jaw_depth + 25.0;
let rail = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, t, h]);
let rail = rail.fillet(4.0, rail.edges("|Y"));
let pitch = length / jaws.to_float();
let jw = min(handle_d + 16.0, pitch - 6.0);
let rh = min(handle_d / 2.0, jw / 2.0 - 4.0);
let yc = out - rh - 2.0;
let parts = [rail];
let cuts = [];
for i in 0..jaws {
    let x = -length / 2.0 + pitch * (i.to_float() + 0.5);
    let jaw = box_from_corners([x - jw / 2.0, t - 0.5, h - jaw_depth], [x + jw / 2.0, out, h]);
    parts.push(jaw.fillet(3.0, jaw.edges("|Z and >Y")));
    cuts.push(cylinder([x, yc, h - jaw_depth - 1.0], "Z", rh, jaw_depth + 2.0));
    cuts.push(box_from_corners([x - rh * 0.82, yc, h - jaw_depth - 1.0], [x + rh * 0.82, out + 1.0, h + 1.0]));
    for s in [-1.0, 1.0] {
        cuts.push(box_from_corners([x + s * (rh + 2.0) - 0.75, t + 3.0, h - jaw_depth - 1.0], [x + s * (rh + 2.0) + 0.75, yc, h + 1.0]));
    }
}
for x in [-length / 2.0 + 15.0, -length / 6.0, length / 6.0, length / 2.0 - 15.0] {
    cuts.push(cylinder([x, -1.0, 12.0], "Y", 2.5, t + 2.0));
    cuts.push(cone(2.5, 5.0, 2.5).rotate_x(-90.0).translate([x, t - 2.49, 12.0]));
}
fuse_all(parts) - fuse_all(cuts)
