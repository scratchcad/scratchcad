// Radiator anti-vibration rubber bobbin: 20 mm rubber body 15 mm long with 1 mm end chamfers and two M6 studs 12 mm long (threads shown plain), one each end, with 0.5 mm tip chamfers
let body_d = 20.0; // [12.0, 40.0] Rubber body diameter (mm)
let body_len = 15.0; // [8.0, 30.0] Rubber body length (mm)
let stud_len = 12.0; // [6.0, 25.0] Stud length (mm)
let stud_d = 6.0; // [4.0, 10.0] Stud diameter (mm)
let r = stud_d / 2.0;
let rb = body_d / 2.0;
face(polygon([
    [0, 0, 0], [r - 0.5, 0, 0], [r, 0, 0.5], [r, 0, stud_len], [rb - 1.0, 0, stud_len], [rb, 0, stud_len + 1.0],
    [rb, 0, stud_len + body_len - 1.0], [rb - 1.0, 0, stud_len + body_len], [r, 0, stud_len + body_len],
    [r, 0, 2.0 * stud_len + body_len - 0.5], [r - 0.5, 0, 2.0 * stud_len + body_len], [0, 0, 2.0 * stud_len + body_len]])).revolve("Z", 360.0)
