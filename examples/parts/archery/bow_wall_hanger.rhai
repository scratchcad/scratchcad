// Bow wall hanger: 50 x 25 x 5 mm backplate with 2 countersunk 4 mm screw holes and a 60 mm padded hook arm 12 mm thick rising 15 mm at the tip
let reach = 60.0; // [40.0, 100.0] Hook reach (mm)
let lip = 15.0; // [8.0, 25.0] Tip lip height (mm)
const t = 5.0;
let plate = box_from_corners([-25.0, 0, 0], [25.0, t, 25.0]);
let plate = plate.fillet(4.0, plate.edges("|Y"));
let arm = box_from_corners([-6.0, t - 0.01, 0], [6.0, t + reach, 10.0]);
let tip = box_from_corners([-6.0, t + reach - 6.0, 9.99], [6.0, t + reach, 10.0 + lip]);
let screws = [];
for x in [-17.0, 17.0] {
    screws.push(cylinder([x, -1.0, 15.0], "Y", 2.1, t + 2.0));
    screws.push(cone(4.2, 2.1, 2.1).rotate_x(90.0).translate([x, t + 0.01, 15.0]));
}
plate + arm + tip - fuse_all(screws)
