// Thorlabs KM100-style kinematic mirror mount for 1 in optics: 38.1 mm square plates, 9.5 mm thick, 25.4 mm optic bore with a nylon-tip set screw, two 1/4-80 adjusters with 9 mm knobs, 8-32 mounting hole
let plate_size = 38.1; // [32.0, 50.0] Plate width (mm)
let plate_thickness = 9.5; // [6.0, 12.0] Plate thickness (mm)
let optic_diameter = 25.4; // [12.7, 30.0] Optic diameter (mm)
let gap = 2.5; // [1.0, 5.0] Gap between plates (mm)
let knob_diameter = 9.0; // [6.0, 14.0] Adjuster knob diameter (mm)
let s = plate_size / 2.0;
let t = plate_thickness;
let a = s - 4.5;
// back plate, in the XZ plane, the beam along +Y
let back = box_from_corners([-s, 0, -s], [s, t, s]).fillet(1.5, "|Y");
let back_cut = [cylinder([0, -1, 0], "Y", optic_diameter / 2.0 - 2.0, t + 2.0),
                cylinder([-a, -1, a], "Y", 1.6, t + 2.0), cylinder([a, -1, -a], "Y", 1.6, t + 2.0),
                cylinder([0, t / 2.0, -s - 1.0], "Z", 1.7, 7.0)];
back = back - compound(back_cut);
// front plate holding the optic
let y1 = t + gap;
let front = box_from_corners([-s, y1, -s], [s, y1 + t, s]).fillet(1.5, "|Y");
let seat = cylinder([0, y1 - 1.0, 0], "Y", optic_diameter / 2.0, t) + cylinder([0, y1 - 1.0, 0], "Y", optic_diameter / 2.0 - 1.0, t + 2.0);
front = front - seat - cylinder([0, y1 + t / 2.0, s + 1.0], "-Z", 1.2, s - optic_diameter / 2.0 + 2.0);
// adjusters: knob behind the back plate, screw through it, tip stopping just short of the front plate
let parts = [back, front];
for p in [[-a, a], [a, -a]] {
    let knob = cylinder([p[0], -7.0, p[1]], "Y", knob_diameter / 2.0, 6.0).chamfer(0.5, "%CIRCLE and <Y");
    let screw = cylinder([p[0], -1.0, p[1]], "Y", 1.2, y1 + 0.7) + sphere([p[0], y1 - 0.3, p[1]], 1.2);
    parts.push(knob + screw);
}
compound(parts)
