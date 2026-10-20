// Ceramic disc capacitor: 5 mm disc 2.5 mm thick on 2.54 mm leads with a dipped meniscus
let disc_d = 5.0; // [3.0, 12.0] Disc diameter (mm)
let thickness = 2.5; // [1.5, 4.0] Disc thickness (mm)
let spacing = 2.54; // [2.54, 7.5] Lead spacing (mm)
let disc = cylinder([0, -thickness / 2.0, disc_d / 2.0 + 2.0], "Y", disc_d / 2.0, thickness).fillet(thickness * 0.45);
let neck = box_centered(spacing + 0.8, thickness * 0.6, 2.0).translate([0, 0, 1.6]);
let leads = cylinder([-spacing / 2.0, 0, -3.0], "Z", 0.25, 5.0) + cylinder([spacing / 2.0, 0, -3.0], "Z", 0.25, 5.0);
fuse_all([disc, neck, leads])
