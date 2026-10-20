// Hummingbird feeder flower port: 32 mm five-petal flower 3 mm thick, raised 3 mm feeding hole, snap-in stem for a 7 mm hole in the reservoir lid
let flower_diameter = 32.0; // [22.0, 45.0] Flower diameter (mm)
let petals = 5; // [4, 8] Number of petals
let thickness = 3.0; // [2.0, 5.0] Petal thickness (mm)
let feed_hole = 3.0; // [2.0, 5.0] Feeding hole diameter (mm)
let lid_hole = 7.0; // [5.0, 10.0] Lid hole the stem snaps into (mm)
let R = flower_diameter / 2.0;
let pr = R * 0.38;
let shapes = [cylinder(R * 0.5, thickness)];
for i in 0..petals {
    let a = i.to_float() * 360.0 / petals.to_float();
    shapes.push(cylinder([R - pr, 0, 0], "Z", pr, thickness).rotate_z(a));
}
let flower = fuse_all(shapes).fillet(0.8, ">Z");
let nectar = cone(6.0, 3.0, 4.0).translate([0, 0, thickness - 0.1]);
let rs = lid_hole / 2.0 - 0.2;
let stem = sketch("XZ").move_to(0, 0.1).hline_to(rs).vline_to(-3.0).hline_to(rs + 0.8).line_to(rs - 0.3, -7.0).hline_to(0).close().to_face().revolve("Z", 360);
let port = fuse_all([flower, nectar, stem]);
port -= cylinder([0, 0, -8.0], "Z", feed_hole / 2.0, 20.0);
port - box_centered(1.2, 2.0 * rs + 3.0, 5.0).translate([0, 0, -5.0])
