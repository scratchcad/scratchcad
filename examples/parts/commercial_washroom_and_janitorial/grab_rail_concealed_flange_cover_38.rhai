// Commercial grab rail concealed-fix flange cover for 38 mm tube: 80 mm cover 22 mm tall with a 2 mm wall, a 38.4 mm tube hole through a 45.4 mm collar 8 mm tall on top of the conical face, and an M4 grub screw hole (3.3 mm tapping) through one side of the collar
let tube_d = 38.0; // [25.0, 42.0] Tube diameter (mm)
let cover_d = 80.0; // [65.0, 100.0] Cover diameter (mm)
let cover_h = 22.0; // [14.0, 30.0] Cover height (mm)
const wall = 2.0;
let rt = tube_d / 2.0 + 0.2;
let rc = rt + 3.5;
let ro = max(cover_d / 2.0, rc + 12.0);
let ch = cover_h - 8.0;
let outer = face(polygon([[rt, 0, 0], [ro, 0, 0], [ro, 0, ch * 0.4], [rc, 0, ch], [rc, 0, cover_h], [rt, 0, cover_h]])).revolve("Z", 360.0);
let inner = face(polygon([[rt, 0, -1.0], [ro - wall, 0, -1.0], [ro - wall, 0, ch * 0.4 - 0.5], [rc - 0.5, 0, ch - wall], [rt, 0, ch - wall]])).revolve("Z", 360.0);
(outer - inner) - cylinder([0, 0, ch + 4.0], "Y", 1.65, ro)
