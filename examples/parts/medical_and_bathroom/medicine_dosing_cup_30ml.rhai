// 30 ml medicine dosing cup: 40 mm at the rim, 32 mm at the base, 1.2 mm wall, raised graduation rings at every 5 ml computed from the cup's taper
let rim_diameter = 40.0; // [34.0, 55.0] Rim outside diameter (mm)
let base_diameter = 32.0; // [22.0, 39.8] Base outside diameter (mm)
let height = 36.0; // [25.0, 50.0] Height (mm)
let wall = 1.2; // [1.0, 2.0] Wall thickness (mm)
let step_ml = 5.0; // [1.0, 10.0] Graduation step (ml)
let r1 = rim_diameter / 2.0;
let r0 = min(base_diameter / 2.0, r1);
let k = (r1 - r0) / height;
let cup = cone(r0, r1, height) - cone(r0 - wall, r1 - wall + k * wall, height).translate([0, 0, wall]);
// volume inside up to height h above the floor, in ml
fn inside_ml(h, a, k) {
    let b = a + k * h;
    PI() * h / 3.0 * (a * a + a * b + b * b) / 1000.0
}
let a = r0 - wall;
let capacity = inside_ml(height - wall, a, k);
let rings = [];
let ml = step_ml;
while ml < capacity {
    let lo = 0.0;
    let hi = height - wall;
    for i in 0..40 {
        let mid = (lo + hi) / 2.0;
        if inside_ml(mid, a, k) < ml { lo = mid; } else { hi = mid; }
    }
    let z = wall + lo;
    rings.push(torus(r0 + k * z, 0.35).translate([0, 0, z]));
    ml += step_ml;
}
print(`capacity ${capacity} ml, ${rings.len()} marks`);
fuse_all([cup] + rings)
