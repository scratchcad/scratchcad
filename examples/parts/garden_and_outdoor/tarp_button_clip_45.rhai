// Tarp button clip, assembled: 45 mm ring housing 10 mm tall with a 6 mm cord eye, 28 mm mushroom button pressing the tarp into a 30 mm tapered seat
let housing_diameter = 45.0; // [35.0, 60.0] Housing diameter (mm)
let seat_diameter = 30.0; // [20.0, 40.0] Seat opening diameter (mm)
let height = 10.0; // [7.0, 15.0] Housing height (mm)
let eye_hole = 6.0; // [4.0, 10.0] Cord eye hole (mm)
let tarp = 0.8; // [0.3, 2.0] Tarp thickness allowance (mm)
let rh = housing_diameter / 2.0;
let rs = min(seat_diameter / 2.0, rh - 4.0);
let housing = cylinder(rh, height).fillet(2.0, ">Z");
housing -= cone(rs, rs - 2.0, height + 0.02).translate([0, 0, -0.01]);
let eye = cylinder([rh + 3.0, 0, 0], "Z", eye_hole / 2.0 + 4.0, height * 0.6) + box_from_corners([rh - 3.0, -eye_hole / 2.0 - 4.0, 0], [rh + 3.0, eye_hole / 2.0 + 4.0, height * 0.6]);
housing = (housing + eye) - cylinder([rh + 3.0, 0, -1.0], "Z", eye_hole / 2.0, height + 2.0);
let gap = tarp + 0.2;
let plug = cone(rs - gap, rs - 2.0 - gap, height).translate([0, 0, 0.5]);
let cap = cylinder([0, 0, height + 0.5 + gap], "Z", rs + 2.5, 3.0).fillet(1.2, ">Z");
let neck = cylinder([0, 0, height], "Z", rs - 2.0 - gap, gap + 0.6);
let button = fuse_all([plug, neck, cap]);
compound([housing, button])
