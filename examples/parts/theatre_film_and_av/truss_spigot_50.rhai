// Truss conical coupler spigot: for 50 mm OD x 3 mm chords (F34 style), 44 mm socket shank 60 mm, 32 mm cone tapering to 26 mm over 50 mm, two 10 mm cross pin holes, 48 mm shoulder
let chord_id = 44.0; // [38.0, 46.0] Chord inside diameter (mm)
let shank = 60.0; // [40.0, 80.0] Shank length (mm)
let cone_base = 32.0; // [26.0, 38.0] Cone base diameter (mm)
let cone_tip = 26.0; // [20.0, 32.0] Cone tip diameter (mm)
let cone_length = 50.0; // [35.0, 70.0] Cone length (mm)
let pin = 10.0; // [8.0, 12.0] Pin hole diameter (mm)
const shoulder = 48.0;
let p = polygon("XZ", [[0, 0], [chord_id / 2.0 - 1.0, 0], [chord_id / 2.0, 1.0], [chord_id / 2.0, shank], [shoulder / 2.0, shank], [shoulder / 2.0, shank + 5.0], [cone_base / 2.0, shank + 5.0], [cone_tip / 2.0, shank + 5.0 + cone_length - 3.0], [cone_tip / 2.0 - 3.0, shank + 5.0 + cone_length], [0, shank + 5.0 + cone_length]]);
let body = p.to_face().revolve([0, 0, 0], "Z", 360);
let pins = cylinder([-shoulder, 0, shank * 0.5], "X", pin / 2.0, shoulder * 2.0) + cylinder([0, -shoulder, shank + 5.0 + cone_length * 0.55], "Y", pin / 2.0, shoulder * 2.0);
body - pins - cylinder([0, 0, -1.0], "Z", 8.0, shank * 0.3)
