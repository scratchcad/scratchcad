// Commercial range open-burner cap: 75 mm brass disc 7 mm thick with a 1.5 mm top chamfer and a 5 mm deep locating ring underneath (55 mm OD, 3 mm wall) that sits in the burner head
let dia = 75.0; // [60.0, 100.0] Cap diameter (mm)
let thick = 7.0; // [5.0, 10.0] Cap thickness (mm)
let ring_d = 55.0; // [40.0, 58.0] Locating ring outside diameter (mm)
const ring_h = 5.0;
const ring_t = 3.0;
let r = dia / 2.0;
let rr = ring_d / 2.0;
face(polygon([[rr - ring_t, 0, 0], [rr, 0, 0], [rr, 0, ring_h], [r, 0, ring_h], [r, 0, ring_h + thick - 1.5], [r - 1.5, 0, ring_h + thick], [0, 0, ring_h + thick], [0, 0, ring_h + 1.0], [rr - ring_t, 0, ring_h + 1.0]])).revolve("Z", 360)
