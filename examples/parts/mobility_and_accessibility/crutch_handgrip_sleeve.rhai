// Forearm crutch handgrip sleeve: anatomic grip 120 mm long for a 22 mm handle bar, 38 mm wide palm shelf tapering to 30 mm at the front, 22.4 mm bore and 10 finger grooves 1.5 mm deep underneath
// # Fit
let bar = 22.0; // [19.0, 25.0] Handle bar diameter (mm)
let length = 120.0; // [100.0, 140.0] Grip length (mm)
// # Grip
let palm_width = 38.0; // [34.0, 48.0] Palm shelf width (mm)
let grip_height = 32.0; // [30.0, 42.0] Grip height (mm)
let ridges = 10; // [4, 14] Number of finger grooves
let bore_r = bar / 2.0 + 0.2;
let pw = palm_width;
let gh = grip_height;
let section = polygon("YZ", [[-pw / 2.0, gh * 0.2], [-bar / 2.0 - 4.0, -gh * 0.2], [-bar / 2.0 - 2.0, -gh / 2.0], [bar / 2.0 + 2.0, -gh / 2.0], [bar / 2.0 + 4.0, -gh * 0.2], [pw / 2.0, gh * 0.2], [pw / 2.0 - 5.0, gh / 2.0], [-pw / 2.0 + 5.0, gh / 2.0]]);
let body = section.to_face().extrude([length, 0, 0]);
let taper = (pw - pw * 0.8) / 2.0;
let ang = (taper / length).atan() * 180.0 / PI();
let trims = [box_from_corners([-1.0, 0, -gh], [length * 2.0, 30.0, gh]).rotate_z(-ang).translate([0, pw / 2.0, 0]), box_from_corners([-1.0, -30.0, -gh], [length * 2.0, 0, gh]).rotate_z(ang).translate([0, -pw / 2.0, 0])];
let rs = [];
for i in 0..ridges {
    let x = 12.0 + i.to_float() * (length - 24.0) / (ridges - 1).to_float();
    rs.push(cylinder([x, -bar, -gh * 0.5 - 2.5], "Y", 4.0, bar * 2.0));
}
let bore = cylinder([-1.0, 0, 0], "X", bore_r, length + 2.0);
body - fuse_all(trims) - fuse_all(rs) - bore
