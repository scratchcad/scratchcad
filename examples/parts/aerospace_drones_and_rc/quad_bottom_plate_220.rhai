// True-X 220 mm quad bottom plate: 3 mm carbon, 36 x 80 mm body with 30.5 mm stack holes and strap slots, four 14 mm arms to 28 mm motor pads
let wheelbase = 220.0; // [150.0, 300.0] Motor-to-motor diagonal (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let reach = wheelbase / 2.0;
let parts = [box_centered(36.0, 80.0, t).translate([0, 0, t / 2.0])];
for a in [45.0, 135.0, 225.0, 315.0] { parts.push((box_from_corners([0, -7, 0], [reach, 7, t]) + cylinder([reach, 0, 0], "Z", 14.0, t)).rotate("Z", a)); }
let plate = fuse_all(parts);
let holes = [];
for x in [-15.25, 15.25] { for y in [-15.25, 15.25] { holes.push(cylinder([x, y, -1], "Z", 1.6, t + 2.0)); } }
for y in [-30.0, 30.0] { holes.push(box_centered(22.0, 3.0, t + 2.0).translate([0, y, t / 2.0])); }
for a in [45.0, 135.0, 225.0, 315.0] {
    holes.push(cylinder([reach, 0, -1], "Z", 3.5, t + 2.0).rotate("Z", a));
    for p in [[11.31, 0.0], [-11.31, 0.0], [0.0, 11.31], [0.0, -11.31]] { holes.push(cylinder([reach + p[0], p[1], -1], "Z", 1.6, t + 2.0).rotate("Z", a)); }
}
plate - fuse_all(holes)
