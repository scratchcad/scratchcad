// Door trim panel fir-tree clip for an 8 mm hole: 16 mm head 1.5 mm thick, 12 mm collar 3 mm for the panel slot, 20 mm sealing umbrella, 4 mm stem 14 mm long with 5 fins 9 mm across
let head_d = 16.0; // [12.0, 24.0] Head diameter (mm)
let umbrella_d = 20.0; // [14.0, 28.0] Umbrella diameter (mm)
let hole_d = 8.0; // [5.0, 10.0] Panel hole size (mm)
let stem_length = 14.0; // [8.0, 22.0] Stem length (mm)
let fins = 5; // [2, 8] Number of fins
const stem_d = 4.0;
let parts = [
    cylinder([0, 0, 0], "Z", stem_d / 2.0, stem_length + 0.2),
    cone(umbrella_d / 2.0, 3.0, 2.5).translate([0, 0, stem_length]),
    cylinder([0, 0, stem_length + 2.4], "Z", 6.0, 3.1),
    cylinder([0, 0, stem_length + 5.4], "Z", head_d / 2.0, 1.5)
];
let pitch = (stem_length - 2.5) / fins.to_float();
for i in 0..fins {
    parts.push(cone(stem_d / 2.0 + 0.1, hole_d / 2.0 + 0.5, pitch * 0.8).translate([0, 0, 0.5 + i.to_float() * pitch]));
}
let clip = fuse_all(parts);
clip - box_centered(1.0, hole_d + 2.0, stem_length - 2.0).translate([0, 0, (stem_length - 2.0) / 2.0 - 0.5])
