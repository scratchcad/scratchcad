// 60 ml screw-cap specimen container, assembled: 48 mm cup 55 mm tall, 1.5 mm wall, 4 mm pitch external thread, 54 mm ribbed cap with matching internal thread
let cup_diameter = 48.0; // [35.0, 70.0] Cup diameter (mm)
let cup_height = 55.0; // [35.0, 90.0] Cup height (mm)
let wall = 1.5; // [1.0, 2.5] Wall thickness (mm)
let thread_pitch = 4.0; // [3.0, 6.0] Thread pitch (mm)
let cap_height = 14.0; // [10.0, 20.0] Cap height (mm)
const turns = 2;
const per_turn = 12;
let r = cup_diameter / 2.0;
let p = thread_pitch;
let zt = cup_height;
let cup = cylinder(r, zt) - cylinder([0, 0, wall], "Z", r - wall, zt);
cup = cup.fillet(2.0, "<Z");
fn helix(section, pitch, turns, per_turn) {
    let s = [];
    for i in 0..=(turns * per_turn) {
        let t = i.to_float() / per_turn.to_float();
        s.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    loft(s, true)
}
let h = 0.3 * p;
let ridge = polygon([[r - 0.3, 0, -h], [r + 1.2, 0, -0.05 * p], [r + 1.2, 0, 0.05 * p], [r - 0.3, 0, h]]);
let z0 = zt - cap_height + 4.0;
let ridge_helix = helix(ridge, p, turns, per_turn).translate([0, 0, z0]);
cup = cup + ridge_helix;
// cap: shell with the mating ridge half a pitch up, and grip ribs outside
let rci = r + 1.5;
let rco = rci + 2.0;
let zc = zt - cap_height + 2.0;
let cap = cylinder([0, 0, zc], "Z", rco, cap_height + 1.0) - cylinder([0, 0, zc - 1.0], "Z", rci, cap_height + 0.5);
let cridge = polygon([[rci + 0.3, 0, -h], [r + 0.3, 0, -0.05 * p], [r + 0.3, 0, 0.05 * p], [rci + 0.3, 0, h]]);
cap = cap + helix(cridge, p, turns, per_turn).translate([0, 0, z0 + p / 2.0]);
let ribs = [];
for i in 0..36 {
    ribs.push(cylinder([rco + 0.2, 0, zc + 1.0], "Z", 0.7, cap_height - 1.0).rotate_z(i.to_float() * 10.0));
}
cap = cap - compound(ribs);
compound([cup, cap])
