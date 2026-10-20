// Bladed spoke holder: 40 mm disc 5 mm thick with four radial slots 12 mm deep for blade thicknesses of 0.9, 1.1, 1.4 and 1.6 mm, 8 mm centre hole, 0.6 mm edge chamfers
let disc_d = 40.0; // [32.0, 55.0] Disc diameter (mm)
let thickness = 5.0; // [3.0, 8.0] Thickness (mm)
let slot_depth = 12.0; // [8.0, 14.0] Slot depth (mm)
let disc = cylinder(disc_d / 2.0, thickness);
let disc = disc.chamfer(0.6, disc.edges(">Z or <Z"));
let depth = min(slot_depth, disc_d / 2.0 - 7.0);
let widths = [0.9, 1.1, 1.4, 1.6];
let cuts = [cylinder([0, 0, -1.0], "Z", 4.0, thickness + 2.0)];
for i in 0..4 {
    cuts.push(box_from_corners([disc_d / 2.0 - depth, -widths[i] / 2.0, -1.0], [disc_d / 2.0 + 1.0, widths[i] / 2.0, thickness + 1.0]).rotate_z(i.to_float() * 90.0));
}
disc - fuse_all(cuts)
