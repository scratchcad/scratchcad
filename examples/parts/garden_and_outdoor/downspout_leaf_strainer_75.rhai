// Wire-ball leaf strainer for a 75 mm round downspout: 76 mm base ring, three 3 mm wire hoops making a 6-rib dome 38 mm high, mid ring, 10 mm push-in collar
let diameter = 76.0; // [50.0, 110.0] Base ring diameter (mm)
let wire_diameter = 3.0; // [2.0, 5.0] Wire diameter (mm)
let hoops = 3; // [2, 5] Number of crossing hoops
let collar = 10.0; // [5.0, 20.0] Collar depth (mm)
let R = diameter / 2.0;
let r = wire_diameter / 2.0;
let half = box_from_corners([-R - 5.0, -R - 5.0, 0], [R + 5.0, R + 5.0, R + 5.0]);
let hub = 4.0 * r;
let parts = [torus(R, r * 1.4), sphere([0, 0, R], hub)];
for i in 0..hoops {
    parts.push((torus(R, r).rotate_x(90.0) & half - cylinder([0, 0, 0], "Z", hub - r, R + 5.0)).rotate_z(i.to_float() * 180.0 / hoops.to_float()));
}
let zm = R * 0.5;
parts.push(torus((R * R - zm * zm).sqrt(), r * 0.75).translate([0, 0, zm]));
parts.push(cylinder([0, 0, -collar], "Z", R - r, collar) - cylinder([0, 0, -collar - 1.0], "Z", R - r - 1.5, collar + 2.0));
fuse_all(parts)
