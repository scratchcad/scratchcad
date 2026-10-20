// PA cabinet 3-way corner protector: 60 mm legs on each face, 2 mm shell, 25 mm wide legs and a 4.5 mm screw hole in each leg
let leg = 60.0; // [40.0, 80.0] Leg length (mm)
let w = 25.0; // [18.0, 35.0] Leg width (mm)
const t = 2.0;
let a = box_from_corners([-t, -t, -t], [leg, w, 0]);
let b = box_from_corners([-t, -t, -t], [w, leg, 0]);
let c = box_from_corners([-t, -t, -t], [w, 0, leg]) + box_from_corners([-t, -t, -t], [0, w, leg]);
let shell = a + b + c;
let holes = [cylinder([leg - 12.0, w / 2.0, -5.0], "Z", 2.25, 10.0), cylinder([w / 2.0, leg - 12.0, -5.0], "Z", 2.25, 10.0), cylinder([w / 2.0, -5.0, leg - 12.0], "Y", 2.25, 10.0), cylinder([-5.0, w / 2.0, leg - 12.0], "X", 2.25, 10.0)];
shell - fuse_all(holes)
