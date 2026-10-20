// 180 mm combination pliers: two 9 mm steel halves lapped at the pivot, serrated flat jaws, side cutters, 5 mm rivet
let len = 180.0; // [140.0, 220.0] Overall length (mm)
fn half(len) {
    let p = polygon([[0, 0], [10, -4], [40, -6], [len - 60.0, -14.0], [len, -12.0], [len, -4.0], [len - 60.0, -2.0], [40, 6], [10, 7], [-45, 6], [-45, 1], [-10, 1]]).to_face().extrude(9.0);
    let teeth = [];
    for k in 0..6 { teeth.push(box_centered(1.0, 3.0, 12.0).translate([-40.0 + k.to_float() * 3.0, 1.0, 4.5])); }
    p - fuse_all(teeth)
}
let a = half(len) - box_from_corners([-15, -10, 4.5], [15, 10, 10]) - cylinder([0, 0, -1], "Z", 2.5, 12.0);
let b = (half(len).mirror([0, 1, 0]) - box_from_corners([-15, -10, -1], [15, 10, 4.5]) - cylinder([0, 0, -1], "Z", 2.5, 12.0)).translate([0, 0, 0]);
let rivet = cylinder([0, 0, -0.5], "Z", 2.4, 10.0) + cylinder([0, 0, -1.0], "Z", 4.0, 0.5) + cylinder([0, 0, 9.0], "Z", 4.0, 0.5);
compound([a, b, rivet])
