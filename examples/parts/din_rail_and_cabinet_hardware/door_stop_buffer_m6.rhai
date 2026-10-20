// Cabinet door stop buffer: 16 mm rubber head 10 mm tall with a 2 mm chamfer on the crown, 12 mm steel base plate 1.5 mm thick moulded in, M6 stud 15 mm long with a 0.5 mm end chamfer
let head_d = 16.0; // [12.0, 30.0] Buffer diameter (mm)
let head_h = 10.0; // [5.0, 20.0] Buffer height (mm)
let stud_len = 15.0; // [8.0, 30.0] Stud length (mm)
const stud_d = 6.0;
const plate_d = 12.0;
const plate_t = 1.5;
let r = head_d / 2.0;
let c = min(2.0, head_h / 3.0);
let head = face(polygon([[0, 0, 0], [r, 0, 0], [r, 0, head_h - c], [r - c, 0, head_h], [0, 0, head_h]])).revolve("Z", 360.0);
let plate = cylinder([0, 0, -plate_t], "Z", plate_d / 2.0, plate_t);
let stud = cylinder([0, 0, -plate_t - stud_len], "Z", stud_d / 2.0, stud_len + 0.5);
let stud = stud.chamfer(0.5, stud.edges("<Z"));
head + plate + stud
