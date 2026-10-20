// Neutrik D-series (XLR / USB / RJ45 D-size) cutout adapter plate: 24 mm main hole, M3 tapped holes on the diagonal 19 x 24 mm (2.5 mm tap drill), 40 x 40 x 3 mm plate with 4 x 3.4 mm corner holes on 32 mm square, 0.8 mm chamfer
let plate = 40.0; // [32.0, 60.0] Plate size (mm)
let thick = 3.0; // [2.0, 5.0] Plate thickness (mm)
let main_hole = 24.0; // [22.0, 26.0] Main hole diameter (mm)
let corner_spacing = 32.0; // [26.0, 52.0] Corner hole spacing (mm)
let p = max(plate, main_hole + 14.0);
let cs = min(max(corner_spacing, main_hole + 6.0), p - 6.0);
let body = box_centered(p, p, thick).translate([0, 0, thick / 2.0]);
let body = body.fillet(3.0, body.edges("|Z"));
let body = body.chamfer(0.8, body.edges(">Z"));
let holes = [cylinder([0, 0, -1], "Z", main_hole / 2.0, thick + 2.0), cylinder([-9.5, 12.0, -1], "Z", 1.25, thick + 2.0), cylinder([9.5, -12.0, -1], "Z", 1.25, thick + 2.0)];
for x in [-cs / 2.0, cs / 2.0] {
    for y in [-cs / 2.0, cs / 2.0] {
        holes.push(cylinder([x, y, -1], "Z", 1.7, thick + 2.0));
    }
}
body - compound(holes)
