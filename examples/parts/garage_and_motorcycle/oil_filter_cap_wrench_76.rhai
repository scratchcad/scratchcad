// Cup-type oil filter wrench, 76 mm 14 flutes (Toyota / Honda): 86 mm cup 22 mm deep, 6 mm top plate with a 3/8 in square drive and a 27 mm hex boss
let flute_d = 76.0; // [64.0, 100.0] Flute peak diameter (mm)
let flutes = 14; // [8, 36] Number of flutes
let cup_depth = 22.0; // [12.0, 35.0] Cup depth (mm)
let wall = 5.0; // [3.0, 8.0] Wall outside the flutes (mm)
let plate = 6.0; // [4.0, 10.0] Top plate thickness (mm)
const drive = 9.6;
const flute_h = 1.6;
let r_in = flute_d / 2.0;
let r_out = r_in + wall + flute_h;
let n = flutes * 2;
let pts = [];
for i in 0..n {
    let a = i.to_float() * 2.0 * PI() / n.to_float();
    let rr = if i % 2 == 0 { r_in } else { r_in + flute_h };
    pts.push([rr * a.cos(), rr * a.sin()]);
}
let cup = cylinder(r_out, cup_depth + plate) - polygon(pts).to_face().extrude([0, 0, cup_depth + 1.0]).translate([0, 0, -1.0]);
let rc = 27.0 / sqrt(3.0);
let hex = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hex.push([rc * a.cos(), rc * a.sin()]); }
let boss = polygon(hex).to_face().extrude([0, 0, 8.0]).translate([0, 0, cup_depth + plate - 0.5]);
let wrench = (cup + boss).chamfer(1.0, "<Z and %CIRCLE");
wrench - box_centered(drive, drive, 2.0 * (plate + 10.0)).translate([0, 0, cup_depth + plate])
