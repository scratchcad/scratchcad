// Air pump anti-vibration rubber foot: 22 mm round foot 10 mm tall with a 2 mm chamfer at the floor, a 6 mm deep, 16 mm recess underneath that acts as a suction cup, and a mushroom stud on top (5 mm neck 2 mm long for a 2 mm pump base, 8 mm head, 4 mm tapered tip) that pops into the pump base
let foot_d = 22.0; // [14.0, 35.0] Foot diameter (mm)
let foot_h = 10.0; // [6.0, 18.0] Foot height (mm)
let neck_d = 5.0; // [3.0, 8.0] Stud neck diameter (mm)
let base_t = 2.0; // [1.0, 4.0] Pump base thickness (mm)
let r = foot_d / 2.0;
let nr = neck_d / 2.0;
let hr = nr + 1.5;
let rd = min(r - 3.0, r * 0.75);
let dd = min(6.0, foot_h - 3.0);
let pts = [[0, 0, dd], [rd, 0, dd], [rd, 0, 1.0], [r - 2.0, 0, 0], [r, 0, 2.0], [r, 0, foot_h - 1.0], [r - 1.0, 0, foot_h],
    [nr, 0, foot_h], [nr, 0, foot_h + base_t], [hr, 0, foot_h + base_t], [hr, 0, foot_h + base_t + 1.0], [nr * 0.6, 0, foot_h + base_t + 4.0],
    [0, 0, foot_h + base_t + 4.0]];
face(polygon(pts)).revolve("Z", 360.0)
