// Blanking piece for unused DIN modules in a distribution board's 45 mm front cover cutout: 1 module (17.8 mm) wide, 44.6 mm tall 2.5 mm face with 1 mm rounded edges, 1.2 mm backing flange 50 mm tall that hooks behind the cover, and a 6 x 2 mm prying notch
let modules = 1; // [1, 12] Number of modules
let cutout = 45.0; // [44.0, 46.0] Cover cutout height (mm)
let face_t = 2.5; // [1.5, 4.0] Face thickness (mm)
const pitch = 17.8;
const flange_t = 1.2;
let w = modules.to_float() * pitch - 0.3;
let h = cutout - 0.4;
let front = box_centered(w, h, face_t).translate([0, 0, face_t / 2.0]);
let front = front.fillet(0.8, front.edges(">Z and #Z"));
let flange = box_centered(w, h + 5.0, flange_t).translate([0, 0, -flange_t / 2.0]);
let notch = box_centered(6.0, 2.0, face_t + 1.0).translate([0, h / 2.0 - 1.0, face_t / 2.0 + 0.5]);
front + flange - notch
