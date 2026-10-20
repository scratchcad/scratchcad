// Steel hub insert for Olympic bumper plates: 50.6 mm bore, 64 mm tube through a 70 mm plate, 90 x 4 mm flange on one face, retaining ring groove on the other, chamfered bore
let bore_d = 50.6; // [50.4, 52.0] Bore (mm)
let plate_t = 70.0; // [25.0, 100.0] Plate thickness (mm)
let tube_d = 64.0; // [58.0, 80.0] Tube outer diameter (mm)
let flange_d = 90.0; // [70.0, 120.0] Flange diameter (mm)
let flange_t = 4.0; // [2.0, 8.0] Flange thickness (mm)
let bolt_holes = 6; // [0, 8] Number of flange bolt holes
let ro = max(tube_d, bore_d + 6.0) / 2.0;
let fd = max(flange_d, tube_d + 12.0) / 2.0;
let hub = cylinder(ro, plate_t) + cylinder(fd, flange_t);
hub = hub - (cylinder([0, 0, plate_t - 6.0], "Z", ro + 1.0, 1.6) - cylinder([0, 0, plate_t - 7.0], "Z", ro - 1.2, 4.0));
hub = hub - cylinder([0, 0, -1.0], "Z", bore_d / 2.0, plate_t + 2.0);
hub = hub.chamfer(1.5, hub.edges("%CIRCLE").filter(|e| abs(e.radius() - bore_d / 2.0) < 0.01));
for i in 0..bolt_holes {
    let a = i.to_float() * 2.0 * PI() / bolt_holes.to_float();
    let rr = (ro + fd) / 2.0;
    hub = hub - cylinder([rr * a.cos(), rr * a.sin(), -1.0], "Z", 2.6, flange_t + 2.0);
}
hub
