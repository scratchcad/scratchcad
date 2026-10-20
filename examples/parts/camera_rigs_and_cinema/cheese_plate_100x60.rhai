// Camera cheese plate 100 x 60 x 8 mm with 2 mm chamfered edges: grid of 1/4-20 tapped holes (5.1 mm core) on 12.5 mm pitch, a row of 3/8-16 holes (8 mm core) on the centreline every 25 mm, and two 6.5 x 25 mm slots for 1/4-20 screws
let length = 100.0; // [60.0, 200.0] Plate length (mm)
let width = 60.0; // [50.0, 100.0] Plate width (mm)
let thickness = 8.0; // [6.0, 12.0] Plate thickness (mm)
const pitch = 12.5;
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let plate = plate.chamfer(1.5, plate.edges("|Z"));
let cuts = [];
let nx = ((length - 12.0) / pitch).to_int();
for i in 0..nx {
    let x = (i.to_float() - (nx.to_float() - 1.0) / 2.0) * pitch;
    for y in [-width / 2.0 + 7.0, width / 2.0 - 7.0] {
        cuts.push(cylinder([x, y, -1.0], "Z", 2.55, thickness + 2.0));
    }
}
let nb = ((length - 20.0) / 25.0).to_int() + 1;
for i in 0..nb {
    let x = (i.to_float() - (nb.to_float() - 1.0) / 2.0) * 25.0;
    cuts.push(cylinder([x, 0, -1.0], "Z", 4.0, thickness + 2.0));
}
for s in [-1.0, 1.0] {
    let y = s * (width / 2.0 - 7.0) / 2.0 - s * 1.0;
    cuts.push(box_centered(25.0 - 6.5, 6.5, thickness + 2.0).translate([0, y, thickness / 2.0])
        + cylinder([-(25.0 - 6.5) / 2.0, y, -1.0], "Z", 3.25, thickness + 2.0) + cylinder([(25.0 - 6.5) / 2.0, y, -1.0], "Z", 3.25, thickness + 2.0));
}
plate - fuse_all(cuts)
