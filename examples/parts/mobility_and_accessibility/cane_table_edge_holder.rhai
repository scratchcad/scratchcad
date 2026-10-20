// Cane table-edge holder: clip that hangs a walking cane on a table edge, 30 mm wide, U-clamp for 18 to 26 mm table tops with 3 mm wall and a grip ridge, 19 mm C-clip for the cane shaft with 14 mm snap mouth
// # Table
let table = 26.0; // [15.0, 45.0] Table top thickness (mm)
let depth = 30.0; // [20.0, 45.0] Clamp depth onto the table (mm)
let width = 30.0; // [20.0, 40.0] Holder width (mm)
let wall = 3.0; // [2.5, 5.0] Wall thickness (mm)
// # Cane
let cane = 19.0; // [16.0, 25.0] Cane shaft diameter (mm)
let u = box_from_corners([0, 0, 0], [depth + wall, width, table + 2.0 * wall]) - box_from_corners([-1.0, -1.0, wall], [depth, width + 1.0, table + wall]);
let ridge = box_from_corners([2.0, 0, table + wall - 1.5], [4.0, width, table + wall + 0.01]);
let rc = cane / 2.0;
let ro = rc + wall;
let cx = depth + wall + ro - 1.0;
let cz = table / 2.0 + wall;
let ring = cylinder([cx, 0, cz], "Y", ro, width) - cylinder([cx, -1.0, cz], "Y", rc, width + 2.0) - box_from_corners([cx, -1.0, cz - rc * 0.74], [cx + ro + 1.0, width + 1.0, cz + rc * 0.74]);
u + ridge + ring
