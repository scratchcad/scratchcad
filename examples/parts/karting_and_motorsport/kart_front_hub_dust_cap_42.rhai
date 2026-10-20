// Kart front hub dust cap: press-in cap for a 42 mm hub bore, 46 mm flange 2 mm thick with a 0.5 mm chamfer, 8 mm skirt with 1.5 mm walls and a 0.3 mm press rib, closed face with a 12 mm hex recess 2 mm deep for removal
let bore_d = 42.0; // [30.0, 55.0] Hub bore diameter (mm)
let skirt_len = 8.0; // [5.0, 15.0] Skirt length (mm)
let flange_extra = 2.0; // [1.0, 5.0] Flange overhang (mm)
const wall = 1.5;
const face_t = 2.0;
let r = bore_d / 2.0;
let rf = r + flange_extra;
let profile = polygon([
    [0, 0, 0], [rf - 0.5, 0, 0], [rf, 0, 0.5], [rf, 0, face_t], [r, 0, face_t], [r, 0, face_t + skirt_len * 0.5 - 0.5], [r + 0.3, 0, face_t + skirt_len * 0.5],
    [r, 0, face_t + skirt_len * 0.5 + 0.5], [r, 0, face_t + skirt_len - 0.8], [r - 0.8, 0, face_t + skirt_len], [r - wall, 0, face_t + skirt_len], [r - wall, 0, face_t], [0, 0, face_t]]);
let cap = face(profile).revolve("Z", 360.0);
let rc = 6.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
cap - face(polygon(pts)).extrude([0, 0, 3.0]).translate([0, 0, -1.0])
