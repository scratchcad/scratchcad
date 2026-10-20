// Condensate / overflow pipe saddle clip for 21.5 mm pipe: half-round strap 2 mm thick, 15 mm wide, two 18 mm ears with 4.5 mm screw holes
let pipe = 21.5; // [15.0, 32.0] Pipe diameter (mm)
let thick = 2.0; // [1.5, 3.0] Strap thickness (mm)
let width = 15.0; // [10.0, 25.0] Strap width (mm)
let ear = 18.0; // [12.0, 25.0] Ear length (mm)
let screw = 4.5; // [3.0, 6.0] Screw hole diameter (mm)
let ri = pipe / 2.0;
let ro = ri + thick;
let arch = cylinder([0, 0, 0], "Y", ro, width) - cylinder([0, -1, 0], "Y", ri, width + 2.0) - box_from_corners([-ro - 1.0, -1, -ro - 1.0], [ro + 1.0, width + 1.0, 0]);
let ears = box_from_corners([-ro - ear, 0, 0], [ro + ear, width, thick]) - box_from_corners([-ri, -1, -1], [ri, width + 1.0, thick + 1.0]);
let ears = ears.fillet(min(width * 0.4, 5.0), ears.edges("|Z").filter(|e| e.center().x.abs() > ro + ear - 0.1));
let holes = compound([cylinder([-ro - ear / 2.0, width / 2.0, -1], "Z", screw / 2.0, thick + 2.0), cylinder([ro + ear / 2.0, width / 2.0, -1], "Z", screw / 2.0, thick + 2.0)]);
(arch + ears - holes).mirror([0, 0, 1]).translate([0, 0, ro])
