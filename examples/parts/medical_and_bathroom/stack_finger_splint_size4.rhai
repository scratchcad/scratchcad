// Stack mallet-finger splint, size 4: fingertip shell for a 17 mm finger, 50 mm long, 1.8 mm wall, closed rounded tip, dorsal ventilation window and tape notch
let finger_diameter = 17.0; // [12.0, 24.0] Finger diameter (mm)
let length = 50.0; // [35.0, 70.0] Splint length (mm)
let wall = 1.8; // [1.2, 3.0] Wall thickness (mm)
let window_length = 14.0; // [6.0, 25.0] Ventilation window length (mm)
let ri = finger_diameter / 2.0 + 0.3;
let ro = ri + wall;
let L = length - ro;
let outer = cylinder([0, 0, 0], "Y", ro, L) + sphere([0, L, 0], ro);
let inner = cylinder([0, -1.0, 0], "Y", ri, L + 1.0) + sphere([0, L, 0], ri);
let shell = outer - inner;
// open the palm side near the base so the splint slides on, and cut a dorsal window
shell -= box_from_corners([-ri * 0.7, -1.0, -ro - 1.0], [ri * 0.7, L * 0.45, 0]);
let wl = min(window_length, L * 0.5);
shell -= box_from_corners([-ri * 0.45, L * 0.5 - wl / 2.0, 0], [ri * 0.45, L * 0.5 + wl / 2.0, ro + 1.0]).fillet(2.0, "|Z");
shell -= box_from_corners([-ro - 1.0, L * 0.2 - 2.0, -1.0], [ro + 1.0, L * 0.2 + 2.0, -ri * 0.2]);
shell
