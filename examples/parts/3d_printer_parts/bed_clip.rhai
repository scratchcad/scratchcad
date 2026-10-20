// Glass bed clip: 3 mm glass on 3 mm aluminium bed, 15 mm wide U-clip 1.5 mm thick, 12 mm reach
let glass = 3.0; // [2.0, 5.0] Glass thickness (mm)
let bed = 3.0; // [2.0, 6.0] Bed thickness (mm)
let width = 15.0; // [8.0, 25.0] Clip width (mm)
let t = 1.5; // [1.0, 3.0] Clip thickness (mm)
let reach = 12.0; // [6.0, 20.0] Reach over the edge (mm)
let gap = glass + bed - 0.3;
let clip = box(reach + t, width, gap + 2.0 * t) - box_from_corners([-1, -1, t], [reach, width + 1, t + gap]);
clip.fillet(0.6, "|Y and >X")
