// Thumb page holder for reading: 34 mm ring with a 22 mm thumb hole, two 35 mm wings 20 mm wide drooping 6 degrees to hold both pages flat, 3 mm thick, rounded wing tips
let thumb = 22.0; // [16.0, 28.0] Thumb hole diameter (mm)
let wing = 35.0; // [20.0, 55.0] Wing length beyond the ring (mm)
let wing_w = 20.0; // [12.0, 30.0] Wing width (mm)
let droop = 6.0; // [0.0, 15.0] Wing droop (degrees)
let t = 3.0; // [2.0, 5.0] Thickness (mm)

let ro = thumb / 2.0 + 6.0;
let ring = cylinder(ro, t);
let wings = [];
for s in [-1.0, 1.0] {
    let w = box_from_corners([0, -wing_w / 2.0, 0], [ro + wing, wing_w / 2.0, t]);
    w = w.fillet(wing_w / 2.0 - 0.5, w.edges("|Z and >X"));
    w = w.rotate([0, 0, 0], "Y", droop);
    if s < 0.0 { w = w.rotate_z(180.0); }
    wings.push(w.translate([s * (ro - 4.0), 0, 0]));
}
let holder = fuse_all([ring, fuse_all(wings)]);
holder = holder - cylinder([0, 0, -t], "Z", thumb / 2.0, 3.0 * t);
holder.translate([0, 0, (ro + wing) * sin(droop * PI() / 180.0)])
