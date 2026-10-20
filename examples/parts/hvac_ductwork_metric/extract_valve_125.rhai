// Ceiling extract valve 125 mm (disc valve): 165 mm conical face ring, 123 mm OD mounting collar 40 mm long, 1.5 mm wall, cross bar with an 8 mm spindle carrying a 105 mm conical disc set 12 mm below the face
let collar_d = 123.0; // [80.0, 200.0] Collar outside diameter (mm)
let face_extra = 21.0; // [10.0, 35.0] Face ring width beyond the collar (mm)
let collar_l = 40.0; // [25.0, 70.0] Collar length (mm)
let gap = 12.0; // [4.0, 25.0] Disc opening gap (mm)
let disc_frac = 0.85; // [0.7, 0.95] Disc size relative to the collar
const wall = 1.5;
const face_h = 10.0;
let rc = collar_d / 2.0;
let ri = rc - wall;
let rr = rc + face_extra;
let ring = polygon([[ri, 0, 0], [rr, 0, 0], [rr, 0, 3.0], [rc + 2.0, 0, face_h], [rc, 0, face_h], [rc, 0, face_h + collar_l], [ri, 0, face_h + collar_l]]).to_face().revolve("Z", 360);
let zb = face_h + collar_l - 8.0;
let bar = box_centered(2.0 * ri + 1.0, 8.0, 4.0).translate([0, 0, zb]);
let spindle = cylinder([0, 0, -gap], "Z", 4.0, zb + gap);
let rd = collar_d * disc_frac / 2.0;
let disc = cone(rd, 12.0, 14.0).translate([0, 0, -gap - 4.0]);
fuse_all([ring, bar, spindle, disc])
