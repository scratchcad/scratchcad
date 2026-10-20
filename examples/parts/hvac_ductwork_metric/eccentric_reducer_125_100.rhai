// Flat-bottom eccentric duct reducer 125 to 100 mm: 124 mm OD and 99 mm OD spigots 40 mm long, 60 mm offset transition keeping the bottom line straight, 1.5 mm wall
let large_d = 124.0; // [110.0, 200.0] Large spigot outside diameter (mm)
let small_d = 99.0; // [60.0, 105.0] Small spigot outside diameter (mm)
let collar = 40.0; // [25.0, 80.0] Spigot length (mm)
let transition = 60.0; // [40.0, 150.0] Transition length (mm)
let wall = 1.5; // [1.2, 3.0] Wall thickness (mm)
let r1 = large_d / 2.0;
let r2 = small_d / 2.0;
let off = r1 - r2;
let z1 = collar;
let z2 = collar + transition;
let outer = fuse_all([
    cylinder(r1, z1),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), r1), circle(plane([-off, 0, z2], [0, 0, 1]), r2)], true),
    cylinder([-off, 0, z2], "Z", r2, collar)]);
let hollow = fuse_all([
    cylinder([0, 0, -1], "Z", r1 - wall, z1 + 1.0),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), r1 - wall), circle(plane([-off, 0, z2], [0, 0, 1]), r2 - wall)], true),
    cylinder([-off, 0, z2], "Z", r2 - wall, collar + 1.0)]);
outer - hollow
