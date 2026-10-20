// UK single light switch plate: 86 x 86 x 8 mm, bevelled edge, 60.3 mm screw centres, 22 x 22 mm rocker aperture
let size = 86.0; // [70.0, 90.0] Plate size (mm)
let depth = 8.0; // [4.0, 12.0] Depth (mm)
let screw_centres = 60.3; // [60.3, 60.3] Screw centres (mm)
let aperture = 22.0; // [10.0, 40.0] Rocker aperture (mm)
let plate = box_centered(size, size, depth).translate([0, 0, depth / 2.0]).fillet(4.0, "|Z").chamfer(3.0, ">Z");
plate = plate.shell(-1.5, "<Z");
plate = plate - box_centered(aperture, aperture, depth * 3.0);
for s in [-1, 1] {
    plate -= cylinder([s * screw_centres / 2.0, 0, -1], "Z", 1.75, depth + 2.0);
    plate -= cone(1.75, 3.5, 1.76).translate([s * screw_centres / 2.0, 0, depth - 1.75]);
}
plate
