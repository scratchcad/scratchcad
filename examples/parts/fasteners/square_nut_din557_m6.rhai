// Square nut DIN 557 M6: 10 mm square, 5 mm thick, 30 deg chamfer on the top side only, 5 mm bore with countersink
let thread_diameter = 6.0; // [3.0, 16.0] Thread size (mm)
let width = 10.0; // [5.5, 24.0] Width across flats (mm)
let thickness = 5.0; // [2.4, 13.0] Thickness (mm)
let w = max(width, thread_diameter * 1.4);
let nut = box_centered(w, w, thickness).translate([0, 0, thickness / 2.0]);
let rc = w / sqrt(2.0) + 0.2;
let rw = w * 0.95 / 2.0;
let dz = min((rc - rw) * (30.0 * PI() / 180.0).tan(), thickness * 0.6);
let crown = polygon([[0, 0, -0.5], [rc, 0, -0.5], [rc, 0, thickness - dz], [rw, 0, thickness], [0, 0, thickness]]).to_face().revolve("Z", 360);
nut = nut & crown;
let tap = thread_diameter * 0.84;
nut - cylinder([0, 0, -1], "Z", tap / 2.0, thickness + 2.0) - cone(thread_diameter / 2.0 + 0.3, tap / 2.0, 0.6).translate([0, 0, -0.01])
