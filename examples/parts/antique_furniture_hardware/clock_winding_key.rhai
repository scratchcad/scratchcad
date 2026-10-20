// Mantel clock winding key size 6 (3.75 mm square): 4.5 mm barrel 15 mm, 30 x 18 mm wing grip 3 mm
let square = 3.75; // [2.25, 5.5] Arbor square (mm)
let barrel_l = 15.0; // [10.0, 25.0] Barrel length (mm)
let barrel = cylinder(square / 2.0 * 1.414 + 1.5, barrel_l);
let wing = polygon([[-15.0, 0], [-9.0, 9.0], [9.0, 9.0], [15.0, 0], [9.0, -9.0], [-9.0, -9.0]]).to_face().extrude([0, 0, 3.0]).rotate_x(90.0).translate([0, 1.5, barrel_l + 8.0]);
barrel + wing - box_centered(square + 0.1, square + 0.1, 24.0)
