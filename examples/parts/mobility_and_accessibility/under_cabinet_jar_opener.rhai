// Under-cabinet jar opener: V-wedge plate 150 x 110 x 12 mm screwed under a shelf, 60 degree V with 14 saw-tooth grip ridges 2 mm high, 3 countersunk 4 mm screw holes; opens lids 25 to 100 mm
// # Plate
let length = 150.0; // [120.0, 200.0] Plate length (mm)
let width = 110.0; // [90.0, 140.0] Plate width at the mouth (mm)
let thickness = 12.0; // [8.0, 16.0] Plate thickness (mm)
// # Grip
let vee_angle = 60.0; // [40.0, 75.0] V opening angle (degrees)
let teeth = 14; // [6, 24] Number of grip teeth per side
let half = vee_angle / 2.0 * PI() / 180.0;
let vee_len = length - 20.0;
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]).fillet(8.0, "|Z and >X");
let mouth = vee_len * half.sin() / half.cos();
let mouth_half = min(mouth, width / 2.0 - 8.0);
let vee = polygon([[-1.0, -mouth_half - 0.01], [vee_len, 0.0], [-1.0, mouth_half + 0.01]]).extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
let body = plate - vee;
let ridges = [];
let ang = (mouth_half / vee_len).atan() * 180.0 / PI();
for s in [-1.0, 1.0] {
    for i in 0..teeth {
        let t = (i.to_float() + 0.5) / teeth.to_float();
        let x = t * vee_len;
        let y = s * mouth_half * (1.0 - t);
        ridges.push(box_centered(2.0, 3.0, thickness).rotate_z(-s * ang).translate([x - 0.5, y, thickness / 2.0]));
    }
}
let holes = [];
for p in [[length - 10.0, 0.0], [12.0, width / 2.0 - 10.0], [12.0, -width / 2.0 + 10.0]] {
    holes.push(cylinder([p[0], p[1], -1.0], "Z", 2.2, thickness + 2.0));
    holes.push(cone(2.2, 4.4, 2.2).translate([p[0], p[1], thickness - 2.19]));
}
body + fuse_all(ridges) - fuse_all(holes)
