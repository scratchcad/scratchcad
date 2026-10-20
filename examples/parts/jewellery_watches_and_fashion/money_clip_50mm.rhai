// Spring money clip, 50 x 25 mm: 1.5 mm thick plate folded on a 2.25 mm inside radius, 45 mm back leaf angled up so its tip touches the front, rounded corners
let length = 50.0; // [35.0, 70.0] Front length (mm)
let width = 25.0; // [15.0, 35.0] Width (mm)
let thickness = 1.5; // [1.0, 2.5] Plate thickness (mm)
let fold_radius = 2.25; // [1.0, 4.0] Fold inside radius (mm)
let back_length = 45.0; // [25.0, 65.0] Back leaf length (mm)
let zc = -fold_radius;
let front = box_from_corners([0, 0, 0], [length, width, thickness]).fillet(4.0, "|Z and >X");
let fold = cylinder([0, 0, zc], "Y", fold_radius + thickness, width) - cylinder([0, -1, zc], "Y", fold_radius, width + 2.0);
fold = fold & box_from_corners([-10, -1, -20], [0, width + 1.0, 10]);
let bl = min(back_length, length - 2.0);
let back = box_from_corners([-0.3, 0, zc - fold_radius - thickness], [bl, width, zc - fold_radius]).fillet(3.0, "|Z and >X");
// tilt the back leaf about its root so the tip rises to 0.2 mm under the front
let rise = 2.0 * fold_radius - 0.2;
let tilt = (rise / bl).atan() * 180.0 / PI();
back = back.rotate([0, 0, zc - fold_radius - thickness / 2.0], "Y", -tilt);
fuse_all([front, fold, back])
