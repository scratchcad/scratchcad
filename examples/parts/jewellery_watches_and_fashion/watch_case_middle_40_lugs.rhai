// Watch case middle, 40 mm: 9 mm tall ring with a 31 mm movement bore and 33 mm crystal seat, four lugs for a 20 mm strap with 1.0 mm drilled spring-bar holes, crown tube hole at 3 o'clock
let case_diameter = 40.0; // [34.0, 46.0] Case diameter (mm)
let case_height = 9.0; // [6.0, 14.0] Case height (mm)
let movement_diameter = 31.0; // [24.0, 38.0] Movement bore (mm)
let lug_width = 20.0; // [16.0, 24.0] Strap width between lugs (mm)
let lug_length = 8.0; // [5.0, 12.0] Lug length beyond the case (mm)
let ro = case_diameter / 2.0;
let rm = min(movement_diameter / 2.0, ro - 2.5);
let case_ring = cylinder(ro, case_height) - cylinder([0, 0, -1], "Z", rm, case_height + 2.0);
case_ring = case_ring - cylinder([0, 0, case_height - 1.5], "Z", rm + 1.0, 2.0);
let lugs = [];
let xl = lug_width / 2.0;
let y_end = (ro * ro - (xl + 1.2) * (xl + 1.2)).sqrt() + lug_length;
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let lug = box_from_corners([0, 0, 1.0], [2.4, y_end - 6.0, case_height - 2.0]).fillet(1.0, "|X and >Y");
        let x0 = if sx > 0.0 { xl } else { -xl - 2.4 };
        lug = lug.translate([x0, 6.0, 0]);
        if sy < 0.0 { lug = lug.mirror("Y"); }
        lugs.push(lug);
    }
}
let case_middle = fuse_all([case_ring] + lugs);
// spring-bar holes through both lugs of each pair, crown tube through the wall at +X
let bar_y = y_end - 2.0;
case_middle = case_middle - cylinder([-xl - 4.0, bar_y, case_height / 2.0], "X", 0.5, lug_width + 8.0) - cylinder([-xl - 4.0, -bar_y, case_height / 2.0], "X", 0.5, lug_width + 8.0);
case_middle - cylinder([rm - 1.0, 0, case_height / 2.0], "X", 1.25, ro - rm + 2.0)
