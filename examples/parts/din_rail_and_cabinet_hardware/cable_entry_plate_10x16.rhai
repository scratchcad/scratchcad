// Cable entry plate for a cabinet floor: 235 x 60 x 4 mm with a 2 mm raised border, ten 16.5 mm holes for push-in M16 grommets on a 20.5 mm pitch in a single row, four 6.5 mm fixing holes 8 mm in from the ends
let holes = 10; // [2, 14] Number of grommet holes
let hole_d = 16.5; // [10.0, 22.0] Grommet hole diameter (mm)
let thickness = 4.0; // [2.0, 6.0] Plate thickness (mm)
const width = 60.0;
const border = 2.0;
let pitch = hole_d + 4.0;
let length = holes.to_float() * pitch + 30.0;
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let rim = box_centered(length, width, border).translate([0, 0, thickness + border / 2.0 - 0.5])
    - box_centered(length - 6.0, width - 6.0, border + 2.0).translate([0, 0, thickness + border / 2.0]);
let rim = rim.fillet(3.0, rim.edges("|Z and (<X or >X) and (<Y or >Y)"));
let cuts = [];
for i in 0..holes {
    let x = (i.to_float() - (holes.to_float() - 1.0) / 2.0) * pitch;
    cuts.push(cylinder([x, 0, -1.0], "Z", hole_d / 2.0, thickness + 2.0));
}
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        cuts.push(cylinder([sx * (length / 2.0 - 8.0), sy * (width / 2.0 - 12.0), -1.0], "Z", 3.25, thickness + 2.0));
    }
}
plate + rim - fuse_all(cuts)
