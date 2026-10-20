// ISO 4035 M10 thin hex nut: 16 mm AF, 5 mm thick, chamfered both faces
let across_flats = 16.0; // [10.6, 30.0] Width across flats (mm)
let thickness = 5.0; // [2.5, 12.0] Thickness (mm)
let bore = 8.5; // [4.0, 15.4] Bore (minor diameter) (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(thickness);
let env = cone(rc + 2.0, across_flats * 0.45, rc + 2.0 - across_flats * 0.45) ;
let crown = sketch("XZ").move_to(0, -0.01).hline_to(across_flats * 0.48).line_to(rc + 0.5, (rc + 0.5 - across_flats * 0.48) * 0.577)
    .vline_to(thickness - (rc + 0.5 - across_flats * 0.48) * 0.577).line_to(across_flats * 0.48, thickness + 0.01).hline_to(0).close().to_face().revolve("Z", 360);
(hex & crown) - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0)
