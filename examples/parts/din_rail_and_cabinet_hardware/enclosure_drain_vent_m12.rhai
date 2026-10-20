// Condensate drain and breather vent for an enclosure floor, M12 x 1.5: 10 mm threaded stud with a 6 mm bore, 17 mm hex flange 4 mm thick, 24 mm umbrella cap 6 mm above the flange on four 2 mm legs leaving 4 vent gaps
let thread_d = 12.0; // [12.0, 25.0] Thread size (mm)
let cap_d = 24.0; // [22.0, 40.0] Cap diameter (mm)
let thread_len = 10.0; // [6.0, 16.0] Thread length (mm)
const hex_h = 4.0;
const cap_gap = 6.0;
const cap_t = 2.0;
let cap_r = max(cap_d, thread_d + 8.0) / 2.0;
let af = thread_d + 5.0;
let rh = af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rh * cos(a), rh * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]);
let stud = cylinder([0, 0, -thread_len], "Z", thread_d / 2.0, thread_len + 0.5);
let legs = [];
for i in 0..4 {
    legs.push(box_centered(2.0, thread_d / 2.0 - 0.5, cap_gap + 1.0).translate([0, thread_d / 4.0 + 1.0, hex_h + cap_gap / 2.0]).rotate_z(i.to_float() * 90.0 + 45.0));
}
let cap = face(polygon([[0, 0, hex_h + cap_gap], [cap_r, 0, hex_h + cap_gap], [cap_r, 0, hex_h + cap_gap + cap_t], [cap_r - 2.0, 0, hex_h + cap_gap + cap_t + 2.0], [0, 0, hex_h + cap_gap + cap_t + 2.0]])).revolve("Z", 360.0);
let bore = cylinder([0, 0, -thread_len - 1.0], "Z", thread_d / 4.0, thread_len + hex_h + 1.0 + 3.0);
hex + stud + fuse_all(legs) + cap - bore
