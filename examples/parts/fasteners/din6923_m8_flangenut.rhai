// DIN 6923 M8 hex flange nut: 13 mm AF, 17.9 mm flange, 8 mm high
let across_flats = 13.0; // [8.0, 30.0] Width across flats (mm)
let flange_d = 17.9; // [11.8, 40.0] Flange diameter (mm)
let height = 8.0; // [5.0, 20.0] Overall height (mm)
let flange_t = 1.5; // [0.8, 4.0] Flange edge thickness (mm)
let bore = 6.8; // [4.0, 20.0] Bore (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(height).chamfer(0.5, ">Z");
let flange = cone(flange_d / 2.0, across_flats / 2.0, flange_t * 2.0) ;
(hex + flange) - cylinder([0, 0, -1], "Z", bore / 2.0, height + 2.0)
