// 22 mm copper pipe snap clip (one-piece push-in): 22.2 mm saddle, 2.4 mm ring wall, 18 mm snap opening, 32 x 3 mm base 12 mm wide, 4.5 mm screw hole
let pipe = 22.0; // [10.0, 35.0] Pipe diameter (mm)
let wall = 2.4; // [1.6, 4.0] Ring wall (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let base_t = 3.0; // [2.0, 5.0] Base thickness (mm)
let screw = 4.5; // [3.0, 6.0] Screw hole diameter (mm)
let ri = pipe / 2.0 + 0.1;
let ro = ri + wall;
let opening = pipe * 0.82;
let zc = base_t + ro - 1.0;
let bw = ro * 2.0 + 6.0;
let base = box_from_corners([-bw / 2.0, 0, 0], [bw / 2.0, width, base_t]);
let base = base.fillet(1.5, base.edges("|Z"));
let pedestal = box_from_corners([-ro * 0.6, 0, 0], [ro * 0.6, width, zc]);
let ring = cylinder([0, 0, zc], "Y", ro, width);
let body = base + pedestal + ring;
let gap = box_from_corners([-opening / 2.0, -1, zc + ri * 0.35], [opening / 2.0, width + 1.0, zc + ro + 1.0]);
body - cylinder([0, -1, zc], "Y", ri, width + 2.0) - gap - cylinder([0, width / 2.0, -1], "Z", screw / 2.0, zc)
