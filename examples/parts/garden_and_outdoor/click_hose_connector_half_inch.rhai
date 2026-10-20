// Click-on 1/2 in hose end connector, assembled: 60 mm body, 17 mm socket for the tap nipple, spring collar 29 mm wide, collet nut for 13 mm hose
let socket_diameter = 17.0; // [15.0, 20.0] Socket diameter (mm)
let hose_diameter = 13.0; // [10.0, 19.0] Hose bore (mm)
let body_length = 60.0; // [45.0, 80.0] Body length (mm)
let collar_diameter = 29.0; // [26.0, 36.0] Collar diameter (mm)
let rs = socket_diameter / 2.0;
let rh = hose_diameter / 2.0;
let ro = rs + 2.5;
let p = [[rh - 1.5, 0], [rh + 4.5, 0], [rh + 6.0, 2.0], [rh + 6.0, 22.0], [ro, 24.0], [ro, body_length - 2.0], [ro - 1.0, body_length],
         [rs, body_length], [rs, body_length - 20.0], [rh - 1.5, body_length - 22.0]];
let pts = [];
for q in p { pts.push([q[0], 0, q[1]]); }
let body = polygon(pts).to_face().revolve("Z", 360);
let flats = [];
for i in 0..8 {
    flats.push(box_centered(3.0, 2.0, 18.0).translate([rh + 6.0, 0, 12.0]).rotate_z(i.to_float() * 45.0));
}
body -= compound(flats);
body -= torus(ro, 0.8).translate([0, 0, body_length - 8.0]);
let rc = max(collar_diameter / 2.0, ro + 3.0);
let collar = sketch("XZ").move_to(ro + 0.4, 28.0).hline_to(rc - 1.0).line_to(rc, 30.0).vline_to(44.0).line_to(rc - 1.0, 46.0).hline_to(ro + 0.4).close()
    .to_face().revolve("Z", 360);
let grips = [];
for i in 0..16 {
    grips.push(cylinder([rc + 0.2, 0, 31.0], "Z", 0.8, 12.0).rotate_z(i.to_float() * 22.5));
}
compound([body, collar - compound(grips)])
