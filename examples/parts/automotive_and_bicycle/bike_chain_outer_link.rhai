// 1/2 x 3/32 in bicycle chain outer link: two waisted 0.8 mm plates, 3.6 mm pins, 7.75 mm rollers on 2.4 mm bushings
const pitch = 12.7;
let plate = cylinder(4.0, 0.8) + cylinder([pitch, 0, 0], "Z", 4.0, 0.8) + box_from_corners([0, -3.0, 0], [pitch, 3.0, 0.8]);
let gap = 5.6; // [5.0, 7.5] Inner width between plates (mm)
let parts = [plate, plate.translate([0, 0, gap + 0.8])];
for x in [0.0, pitch] {
    parts.push(cylinder([x, 0, -0.3], "Z", 1.8, gap + 2.2));
    parts.push(cylinder([x, 0, 0.8 + (gap - 2.4) / 2.0], "Z", 3.875, 2.4));
}
fuse_all(parts)
