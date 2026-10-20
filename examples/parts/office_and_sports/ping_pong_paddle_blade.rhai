// Table tennis blade: 157 x 150 mm oval head 6 mm thick, flared 100 mm handle 25 x 30 mm, rounded edges
let thick = 6.0; // [5.0, 7.5] Blade thickness (mm)
let head = sketch().move_to(-78.5, 0).arc_to(0, 75.0, 78.5, 0).arc_to(0, -75.0, -78.5, 0).close().to_face().extrude(thick);
let handle = loft([rect(plane([-75.0, 0, thick / 2.0], "X"), 22.0, thick), rect(plane([-130.0, 0, thick / 2.0], "X"), 25.0, 22.0), rect(plane([-175.0, 0, thick / 2.0], "X"), 30.0, 26.0)], true);
(head + handle).fillet(1.0, ">Z or <Z")
