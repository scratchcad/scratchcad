// Comfort-fit ring blank, US size 7: 17.35 mm inner diameter (54.5 mm circumference), 4 mm wide band, 1.8 mm thick with a domed outside and a slightly crowned comfort-fit inside
let inner_diameter = 17.35; // [14.0, 23.0] Inner diameter (mm)
let band_width = 4.0; // [2.0, 10.0] Band width (mm)
let thickness = 1.8; // [1.2, 3.0] Band thickness (mm)
let ri = inner_diameter / 2.0;
let w = band_width;
let t = thickness;
// the inside bulges 0.15 mm into the finger hole at mid-width, the outside is domed
let profile = sketch("XZ")
    .move_to(ri + 0.15, 0)
    .hline_to(ri + t * 0.6)
    .arc_to(ri + t, w / 2.0, ri + t * 0.6, w)
    .hline_to(ri + 0.15)
    .arc_to(ri, w / 2.0, ri + 0.15, 0)
    .close();
profile.to_face().revolve("Z", 360)
