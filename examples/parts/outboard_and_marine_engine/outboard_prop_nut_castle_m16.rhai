// Outboard castellated propeller nut M16 x 1.5: 24 mm across-flats hex 10 mm tall with 30 degree corner chamfers on both faces, 22 mm crown 6 mm tall with six 4 mm slots 5 mm deep for the split pin, and a 14.4 mm tapped core
let hex_af = 24.0; // [17.0, 30.0] Hex size across flats (mm)
let hex_h = 10.0; // [6.0, 16.0] Hex height (mm)
let crown_h = 6.0; // [5.0, 10.0] Crown height (mm)
let core_d = 14.4; // [8.0, 20.0] Tapped core diameter (mm)
let rc = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]);
let r0 = hex_af / 2.0 - 0.8;
let hc = (rc + 1.0 - r0) * tan(30.0 * PI() / 180.0);
let chamf = face(polygon([[0, 0, 0], [r0, 0, 0], [rc + 1.0, 0, hc], [rc + 1.0, 0, hex_h - hc], [r0, 0, hex_h], [0, 0, hex_h]])).revolve("Z", 360.0);
let hex = hex & chamf;
let core = min(core_d, hex_af - 6.0);
let rcr = min(hex_af / 2.0 - 1.0, core / 2.0 + 4.0);
let crown = cylinder([0, 0, hex_h - 0.5], "Z", rcr, crown_h + 0.5);
let crown = crown.chamfer(0.5, crown.edges(">Z"));
let nut = hex + crown;
let cuts = [cylinder([0, 0, -1.0], "Z", core / 2.0, hex_h + crown_h + 2.0)];
for i in 0..3 {
    cuts.push(box_centered(2.0 * rcr + 4.0, 4.0, 6.0).translate([0, 0, hex_h + crown_h - 5.0 + 3.0]).rotate_z(i.to_float() * 60.0));
}
nut - fuse_all(cuts)
