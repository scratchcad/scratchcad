// Casting funnel stand: 80 mm ring 6 mm thick with a 45 mm funnel seat, standing on three 60 mm legs 6 mm square with 15 mm feet
let seat = 45.0; // [30.0, 70.0] Funnel seat diameter (mm)
let height = 60.0; // [40.0, 100.0] Leg height (mm)
const t = 6.0;
let ring = cylinder([0, 0, height], "Z", seat / 2.0 + 17.5, t) - cylinder([0, 0, height - 1.0], "Z", seat / 2.0, t + 2.0);
let legs = [];
for i in 0..3 { legs.push((box_centered(6.0, 6.0, height + 0.02).translate([seat / 2.0 + 12.0, 0, height / 2.0]) + box_centered(15.0, 15.0, 3.0).translate([seat / 2.0 + 12.0, 0, 1.5])).rotate_z(i.to_float() * 120.0)); }
ring + fuse_all(legs)
