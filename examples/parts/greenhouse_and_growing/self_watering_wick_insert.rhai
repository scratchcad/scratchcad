// Self-watering wick insert: false-bottom platform for a 150 mm pot over a water reservoir, 140 mm disc 3 mm thick with 6 mm drain holes on a 15 mm grid, central 30 mm wicking basket 40 mm deep with 6 slots, 4 legs 40 mm tall and a 15 mm fill-tube socket
// # Platform
let diameter = 140.0; // [100.0, 200.0] Platform diameter (mm)
let thickness = 3.0; // [2.0, 5.0] Platform thickness (mm)
let leg_height = 40.0; // [20.0, 60.0] Leg height (mm)
// # Wick
let basket_d = 30.0; // [20.0, 50.0] Wick basket diameter (mm)
let fill_tube = 15.0; // [10.0, 25.0] Fill tube diameter (mm)
let R = diameter / 2.0;
let zt = leg_height;
let disc = cylinder([0, 0, zt], "Z", R, thickness);
let holes = [];
let n = (R / 15.0).floor().to_int();
for i in -n..=n {
    for j in -n..=n {
        let x = i.to_float() * 15.0;
        let y = j.to_float() * 15.0;
        let d = (x * x + y * y).sqrt();
        if d < R - 8.0 && d > basket_d / 2.0 + 6.0 && ((x - R * 0.6).abs() > fill_tube / 2.0 + 6.0 || y.abs() > fill_tube / 2.0 + 6.0) {
            holes.push(cylinder([x, y, zt - 1.0], "Z", 3.0, thickness + 2.0));
        }
    }
}
let rb = basket_d / 2.0;
let basket = cylinder([0, 0, zt - 40.0], "Z", rb + 2.0, 40.01) - cylinder([0, 0, zt - 38.0], "Z", rb, 50.0);
let slots = [];
for k in 0..6 {
    slots.push(box_from_corners([0, -1.5, zt - 34.0], [rb + 4.0, 1.5, zt - 6.0]).rotate_z(k.to_float() * 60.0));
}
let legs = [];
for k in 0..4 {
    let a = (45.0 + k.to_float() * 90.0) * PI() / 180.0;
    legs.push(cylinder([(R - 10.0) * a.cos(), (R - 10.0) * a.sin(), 0], "Z", 5.0, zt + 0.01));
}
let ft = cylinder([R * 0.6, 0, zt - 10.0], "Z", fill_tube / 2.0 + 2.0, thickness + 20.0) - cylinder([R * 0.6, 0, zt - 11.0], "Z", fill_tube / 2.0, thickness + 22.0);
let through = cylinder([R * 0.6, 0, zt - 1.0], "Z", fill_tube / 2.0, thickness + 2.0);
(disc + basket + fuse_all(legs) + ft) - fuse_all(holes) - fuse_all(slots) - through - cylinder([0, 0, zt - 1.0], "Z", rb, thickness + 2.0)
