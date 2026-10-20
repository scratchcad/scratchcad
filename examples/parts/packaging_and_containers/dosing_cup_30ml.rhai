// Medicine dosing cup, 30 ml: conical cup 40 mm across the top, 30 mm at the base, 36 mm tall, 1 mm wall, with raised graduation rings at 5, 10, 15, 20 and 25 ml
let top_diameter = 40.0; // [34.0, 60.0] Top diameter (mm)
let bottom_diameter = 30.0; // [20.0, 36.0] Bottom diameter (mm)
let height = 36.0; // [20.0, 50.0] Cup height (mm)
let wall = 1.0; // [0.7, 2.0] Wall thickness (mm)
let step_ml = 5.0; // [1.0, 10.0] Graduation step (ml)
let r2 = top_diameter / 2.0;
let r1 = min(bottom_diameter / 2.0, r2);
let cup = cone(r1, r2, height) - cone(r1 - wall, r2 - wall, height).translate([0, 0, wall]);
// inner radius at height z above the inner floor, and the volume below it (in mm^3)
let a = r1 - wall;
let slope = (r2 - r1) / height;
fn volume_to(z, a, slope) {
    let b = a + slope * z;
    PI() * z / 3.0 * (a * a + a * b + b * b)
}
let marks = [cup];
let full = volume_to(height - wall, a, slope);
print(`brim capacity ${full / 1000.0} ml`);
let v = step_ml;
while v * 1000.0 < full {
    // bisection for the height that holds v ml
    let lo = 0.0;
    let hi = height - wall;
    for k in 0..40 {
        let mid = (lo + hi) / 2.0;
        if volume_to(mid, a, slope) < v * 1000.0 { lo = mid; } else { hi = mid; }
    }
    let z = wall + lo;
    let ro = r1 + slope * z;
    marks.push(cylinder([0, 0, z - 0.2], "Z", ro + 0.4, 0.4) - cylinder([0, 0, z - 1.0], "Z", ro - 0.5, 2.0));
    v += step_ml;
}
fuse_all(marks)
