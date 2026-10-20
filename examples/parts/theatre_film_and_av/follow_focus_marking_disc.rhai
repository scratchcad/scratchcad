// Follow focus marking disc: 60 mm white marking ring 4 mm thick snapping onto a 40 mm knob, 12 mm wide writing face, 36 tick grooves 0.5 mm deep (every 10 degrees, longer every 30), witness pointer notch
let diameter = 60.0; // [45.0, 80.0] Disc diameter (mm)
let knob = 40.0; // [25.0, 55.0] Knob diameter (mm)
let thickness = 4.0; // [3.0, 6.0] Disc thickness (mm)
let ticks = 36; // [12, 72] Number of tick marks
let r = diameter / 2.0;
let disc = cylinder(r, thickness) - cylinder([0, 0, -1.0], "Z", knob.min(diameter - 10.0) / 2.0, thickness + 2.0);
let marks = [];
for k in 0..ticks {
    let len = if k % 3 == 0 { 6.0 } else { 3.0 };
    marks.push(box_from_corners([r - len, -0.3, thickness - 0.5], [r + 1.0, 0.3, thickness + 1.0]).rotate_z(k.to_float() * 360.0 / ticks.to_float()));
}
let bead = cylinder([0, 0, 1.0], "Z", knob.min(diameter - 10.0) / 2.0 + 0.01, 1.5) - cylinder([0, 0, 0], "Z", knob.min(diameter - 10.0) / 2.0 - 0.4, 4.0);
disc - fuse_all(marks) + bead
