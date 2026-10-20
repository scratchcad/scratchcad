// Potentiometer panel nut cover for 9 mm / 16 mm pots with M7 x 0.75 bushing: 15 mm cap 4.5 mm tall, 10.2 mm hex pocket 2.6 mm deep for the 10 mm AF nut, 7.3 mm bushing bore, 1 mm top chamfer
let cap_d = 15.0; // [12.0, 22.0] Cap diameter (mm)
let height = 4.5; // [3.0, 8.0] Cap height (mm)
let nut_af = 10.0; // [8.0, 14.0] Nut across flats (mm)
let nut_t = 2.4; // [1.5, 4.0] Nut thickness (mm)
let bushing = 7.0; // [6.0, 10.0] Bushing diameter (mm)
let rc = max(cap_d / 2.0, nut_af / 3.0.sqrt() + 1.2);
let cap = cylinder(rc, height);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let rhex = (nut_af + 0.2) / 3.0.sqrt();
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rhex * a.cos(), rhex * a.sin(), -1.0]);
}
let pocket = polygon(pts).to_face().extrude([0, 0, min(nut_t + 0.2, height - 1.2) + 1.0]);
cap - pocket - cylinder([0, 0, -1], "Z", min(bushing / 2.0 + 0.15, rhex * 0.8), height + 2.0)
