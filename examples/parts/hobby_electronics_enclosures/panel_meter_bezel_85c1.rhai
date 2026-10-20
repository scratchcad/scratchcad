// Bezel for an 85C1 analog panel meter (64 x 56 mm front, 45.5 mm round body, 4 M3 studs about 48 mm apart): 74 x 66 x 3 mm frame, 64.4 x 56.4 mm recess 2 mm deep, 46 mm body hole, 4 x 3.4 mm stud holes
let front_w = 64.0; // [40.0, 100.0] Meter front width (mm)
let front_h = 56.0; // [40.0, 90.0] Meter front height (mm)
let body_d = 46.0; // [30.0, 70.0] Body hole diameter (mm)
let stud_spacing = 48.0; // [30.0, 70.0] Stud spacing (mm)
let border = 5.0; // [3.0, 12.0] Border width (mm)
let thick = 3.0; // [2.0, 5.0] Frame thickness (mm)
let recess = 2.0; // [0.5, 3.0] Front recess depth (mm)
let w = front_w + 2.0 * border;
let h = front_h + 2.0 * border;
let frame = box_centered(w, h, thick + recess).translate([0, 0, (thick + recess) / 2.0]);
let frame = frame.fillet(min(border * 0.6, 4.0), frame.edges("|Z"));
let pocket = box_centered(front_w + 0.4, front_h + 0.4, recess * 2.0).translate([0, 0, thick + recess]);
let ss = min(stud_spacing, min(front_w, front_h) - 4.0);
let rb = min(body_d / 2.0, ss / 2.0 * 1.414 - 3.5);
let holes = [cylinder([0, 0, -1], "Z", rb, thick + recess + 2.0)];
for x in [-ss / 2.0, ss / 2.0] {
    for y in [-ss / 2.0, ss / 2.0] {
        holes.push(cylinder([x, y, -1], "Z", 1.7, thick + recess + 2.0));
    }
}
frame - pocket - compound(holes)
