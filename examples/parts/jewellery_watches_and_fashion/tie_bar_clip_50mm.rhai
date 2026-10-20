// Tie bar (tie clip), 50 mm: 6 mm wide, 1.2 mm thick front bar folded at the left end over a 1.2 mm gap into a 40 mm back bar whose tip rises to grip the tie
let bar_length = 50.0; // [35.0, 65.0] Front bar length (mm)
let width = 6.0; // [3.0, 10.0] Bar width (mm)
let thickness = 1.2; // [0.8, 2.0] Bar thickness (mm)
let gap = 1.2; // [0.6, 3.0] Gap inside the fold (mm)
let back_length = 40.0; // [25.0, 55.0] Back bar length (mm)
let x0 = -bar_length / 2.0;
let zc = -gap / 2.0;
let front = box_from_corners([x0, 0, 0], [bar_length / 2.0, width, thickness]).fillet(width / 2.0 - 0.01, "|Z and >X");
// fold: half a tube around the Y axis at the left end
let fold = cylinder([x0, -0.0, zc], "Y", gap / 2.0 + thickness, width) - cylinder([x0, -1.0, zc], "Y", gap / 2.0, width + 2.0);
fold = fold & box_from_corners([x0 - 10.0, -1.0, -10.0], [x0, width + 1.0, 10.0]);
let bl = min(back_length, bar_length - 3.0);
let back = box_from_corners([x0, 0, -gap - thickness], [x0 + bl, width, -gap]);
// tip pad that rises to touch the front bar's underside
let tip = box_from_corners([x0 + bl - 3.0, 0, -gap - 0.1], [x0 + bl, width, -0.15]).fillet(0.5, "|Y and >Z");
fuse_all([front, fold, back, tip])
