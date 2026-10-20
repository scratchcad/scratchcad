// 25 mm side-release buckle, female half: 38 x 33 x 11 mm shell, 26 x 3.5 mm webbing slot, side windows
let webbing = 25.0; // [15.0, 50.0] Webbing width (mm)
let length = 38.0; // [28.0, 55.0] Body length (mm)
let height = 11.0; // [8.0, 16.0] Height (mm)
let w = webbing + 8.0;
let shell = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, height]);
let s = shell.fillet(2.5, shell.edges("|Z and <X"));
let cavity = box_from_corners([-1.0, -w / 2.0 + 2.0, 1.6], [length - 8.0, w / 2.0 - 2.0, height - 1.6]);
let bar_slot = box_from_corners([length - 6.5, -webbing / 2.0 - 0.5, -1], [length - 3.0, webbing / 2.0 + 0.5, height + 1.0]);
let windows = box_from_corners([8.0, -w, 3.0], [18.0, w, height - 3.0]);
s - cavity - bar_slot - windows
