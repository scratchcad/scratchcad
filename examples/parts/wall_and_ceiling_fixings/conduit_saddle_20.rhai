// 20 mm conduit spacer saddle: 25 mm wide strap over a 20 mm conduit standing 5 mm off the wall, 2 mm thick, two 4.5 mm screw holes on 38 mm centres
let conduit = 20.0; // [16.0, 32.0] Conduit OD (mm)
let width = 25.0; // [15.0, 35.0] Saddle width (mm)
const t = 2.0;
const gap = 5.0;
let r = conduit / 2.0;
let pitch = conduit + 18.0;
let base = box_from_corners([-pitch / 2.0 - 6.0, 0, 0], [pitch / 2.0 + 6.0, width, gap]);
let hoop = cylinder([0, 0, gap + r], "Y", r + t, width) - cylinder([0, -1.0, gap + r], "Y", r, width + 2.0) - box_from_corners([-r - t - 1.0, -1.0, -1.0], [r + t + 1.0, width + 1.0, gap + r]);
let cradle = base - cylinder([0, -1.0, gap + r], "Y", r, width + 2.0);
cradle + hoop + box_from_corners([-r - t, 0, gap - 0.01], [-r, width, gap + r]) + box_from_corners([r, 0, gap - 0.01], [r + t, width, gap + r]) - cylinder([-pitch / 2.0, width / 2.0, -1.0], "Z", 2.25, gap + 2.0) - cylinder([pitch / 2.0, width / 2.0, -1.0], "Z", 2.25, gap + 2.0)
