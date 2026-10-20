// Compression spring with closed and ground ends
let wire_d = 1.0; // [0.5, 2.0] Wire diameter (mm)
let outer_d = 10.0; // [5.0, 20.0] Outside diameter (mm)
let free_length = 30.0; // [10.0, 60.0] Free length (mm)
let active = 8; // [3, 15] Active coils
let r = (outer_d - wire_d) / 2.0;
let dead_pitch = wire_d * 1.05;
let total = active + 2;
const n = 12;
let active_pitch = (free_length + wire_d - 2.0 * dead_pitch) / active.to_float();
// The pitch blends smoothly from the closed end coils to the active pitch.
fn pitch_at(t, total, dead, act) {
    let tt = total.to_float();
    let x = if t < tt / 2.0 { t - 0.5 } else { tt - 0.5 - t };
    let w = if x <= 0.0 { 0.0 } else if x >= 1.0 { 1.0 } else { 0.5 - 0.5 * (x * PI()).cos() };
    dead + (act - dead) * w
}
// Wire sections placed along the helix, each square to the helix direction.
let sections = [];
let z = 0.0 * free_length; // running height (not a parameter)
for i in 0..=(total * n) {
    let t = i.to_float() / n.to_float();
    let a = t * 2.0 * PI();
    let p = pitch_at(t, total, dead_pitch, active_pitch);
    let section = circle([r, 0, 0], [0, 2.0 * PI() * r, p], wire_d / 2.0);
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, z]));
    z += p / n.to_float();
}
// Lofting through many circles at once fails, so loft each turn and fuse the turns.
let turns = [];
for k in 0..total {
    turns.push(loft(sections.extract(k * n, n + 1), true));
}
let coil = fuse_all(turns);
// grind the ends flat
coil & box_from_corners([-outer_d, -outer_d, 0], [outer_d, outer_d, free_length])
