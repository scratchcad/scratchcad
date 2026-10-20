// Flat screwdriver: 30 mm fluted handle 105 mm long with six flutes, 6 mm shaft 100 mm long, 6 x 1 mm flat tip
let shaft_len = 100.0; // [50.0, 200.0] Shaft length (mm)
let tip = 6.0; // [3.0, 8.0] Tip width (mm)
let handle = sketch("XZ").move_to(0, 0).line_to(10.0, 0).line_to(14.0, 10.0).line_to(15.0, 60.0).line_to(13.0, 95.0).arc_to(9.0, 103.0, 0, 105.0).close().to_face().revolve("Z", 360);
let flutes = [];
for k in 0..6 { flutes.push(cylinder([16.5, 0, 18.0], "Z", 3.5, 65.0).rotate("Z", k.to_float() * 60.0)); }
handle -= fuse_all(flutes);
let shaft = cylinder([0, 0, -shaft_len], "Z", 3.0, shaft_len + 20.0);
let tipcut = polygon([[0.5, 0, -shaft_len - 1.0], [5.0, 0, -shaft_len - 1.0], [5.0, 0, -shaft_len + 10.0], [0.5, 0, -shaft_len + 0.01]]).to_face().extrude([0, 8.0, 0]).translate([0, -4.0, 0]);
shaft = shaft - tipcut - tipcut.mirror([1, 0, 0]) - box_from_corners([-5, tip / 2.0, -shaft_len - 1.0], [5, 5, -shaft_len + 12.0]) - box_from_corners([-5, -5, -shaft_len - 1.0], [5, -tip / 2.0, -shaft_len + 12.0]);
handle + shaft
