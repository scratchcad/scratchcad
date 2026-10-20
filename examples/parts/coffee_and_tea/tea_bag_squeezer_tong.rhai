// Tea bag squeezer tongs: two 60 x 30 mm perforated paddles 2 mm on 90 mm spring arms joined at a 10 mm hinge loop
let paddle = 60.0; // [40.0, 80.0] Paddle length (mm)
let width = 30.0; // [20.0, 40.0] Paddle width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let arm = 90.0; // [60.0, 120.0] Arm length (mm)
fn half(paddle, width, t, arm, s) {
    let p = box_from_corners([arm, -width / 2.0, 0], [arm + paddle, width / 2.0, t]);
    let pp = p.fillet(width / 2.0 - 1.0, p.edges("|Z and >X"));
    let holes = [];
    for i in 0..4 { for j in 0..2 { holes.push(cylinder([arm + 10.0 + i.to_float() * 12.0, -6.0 + j.to_float() * 12.0, -1], "Z", 2.0, t + 2.0)); } }
    let a = box_from_corners([0, -4.0, 0], [arm + 0.01, 4.0, t]);
    (pp - compound(holes) + a).rotate([0, 0, 0], "Y", s * 6.0)
}
let hinge = cylinder([0, -4.0, 0], "Y", 6.0, 8.0) - cylinder([0, -5.0, 0], "Y", 6.0 - t, 10.0) - box_from_corners([0.5, -5.0, -7.0], [8.0, 5.0, 7.0]);
half(paddle, width, t, arm, 1.0).translate([0, 0, -6.0]) + half(paddle, width, t, arm, -1.0).translate([0, 0, 6.0 - t]) + hinge
