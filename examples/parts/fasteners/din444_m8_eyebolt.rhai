// DIN 444 B M8 x 60 eye bolt (lifting eye on a rod): 8 mm rod, 20 mm eye, 12 mm thick eye boss
let rod_d = 8.0; // [5.0, 24.0] Thread diameter (mm)
let length = 60.0; // [30.0, 200.0] Length (mm)
let eye_d = 8.2; // [5.0, 24.0] Eye hole (mm)
let eye_outer = 20.0; // [12.0, 50.0] Eye outer diameter (mm)
let eye_t = 8.0; // [5.0, 24.0] Eye thickness (mm)
let eye = cylinder([0, -eye_t / 2.0, length + eye_outer / 2.0 - 2.0], "Y", eye_outer / 2.0, eye_t) - cylinder([0, -eye_t, length + eye_outer / 2.0 - 2.0], "Y", eye_d / 2.0, eye_t * 2.0);
eye + cylinder(rod_d / 2.0, length + 0.5).chamfer(0.7, "<Z")
