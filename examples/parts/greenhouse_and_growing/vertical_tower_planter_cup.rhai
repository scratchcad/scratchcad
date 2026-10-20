// Vertical tower planter cup: 45 degree pocket for a 110 mm aeroponic tower column, 2 in (50 mm) net cup seat 40 mm deep, saddle flange 70 mm tall curved to the 110 mm column with 2 mm wall, four 2 mm hook lugs that catch the column cut-out
// # Pocket
let net_cup = 52.0; // [40.0, 80.0] Net cup seat diameter (mm)
let pocket_depth = 40.0; // [25.0, 60.0] Pocket depth (mm)
let tilt = 45.0; // [30.0, 60.0] Pocket tilt from vertical (degrees)
let wall = 2.0; // [1.5, 3.5] Wall thickness (mm)
// # Column
let column = 110.0; // [75.0, 160.0] Tower column diameter (mm)
let flange_h = 70.0; // [55.0, 100.0] Flange height (mm)
let rc = column / 2.0;
let fw = net_cup + 12.0;
let saddle = (cylinder([0, 0, -flange_h / 2.0], "Z", rc + wall, flange_h) - cylinder([0, 0, -flange_h], "Z", rc, flange_h * 2.0)) & box_from_corners([0, -fw / 2.0, -flange_h / 2.0], [rc + wall + 1.0, fw / 2.0, flange_h / 2.0]);
let ro = net_cup / 2.0 + wall;
let tube = cylinder([0, 0, -pocket_depth], "Z", ro, pocket_depth + ro + 4.0).rotate_y(tilt).translate([rc + ro * 0.4, 0, -4.0]);
let bore = cylinder([0, 0, -pocket_depth + wall], "Z", net_cup / 2.0, pocket_depth + ro + 10.0).rotate_y(tilt).translate([rc + ro * 0.4, 0, -4.0]);
let trim = cylinder([0, 0, -flange_h], "Z", rc, flange_h * 2.0);
let lip = cylinder([0, 0, 0], "Z", ro + 3.0, 2.0).translate([0, 0, ro + 2.0]).rotate_y(tilt).translate([rc + ro * 0.4, 0, -4.0]);
let lugs = [];
for z in [-flange_h / 2.0, flange_h / 2.0 - 3.0] {
    for sy in [-1.0, 1.0] {
        lugs.push(box_from_corners([rc - 10.0, sy * (fw / 2.0 - 1.0) - 3.0, z], [rc + 5.0, sy * (fw / 2.0 - 1.0) + 3.0, z + 3.0]));
    }
}
let band = cylinder([0, 0, -flange_h], "Z", rc + 0.5, flange_h * 2.0) - cylinder([0, 0, -flange_h * 2.0], "Z", rc - 2.0, flange_h * 4.0);
let body = fuse_all([saddle, tube, lip]) - bore - trim;
body + (compound(lugs) & band)
