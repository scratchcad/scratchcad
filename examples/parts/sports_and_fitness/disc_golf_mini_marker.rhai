// Disc golf mini marker disc: 85 mm diameter, 10 mm deep, 2 mm flight plate with a 10 mm wide rounded rim, 1 mm bead on the rim underside
let diameter = 85.0; // [60.0, 110.0] Diameter (mm)
let depth = 10.0; // [6.0, 16.0] Overall depth (mm)
let rim_width = 10.0; // [6.0, 16.0] Rim width (mm)
let plate_t = 2.0; // [1.2, 3.0] Flight plate thickness (mm)
let r = diameter / 2.0;
let rw = min(rim_width, r / 3.0);
let ri = r - rw;
let prof = sketch("XZ").move_to(0, depth).hline_to(r - 3.0).arc_to(r - 0.879, depth - 0.879, r, depth - 3.0)
    .line_to(r - 1.0, 2.0).arc_to(r - rw * 0.5, 0, ri + 1.0, 2.0).line_to(ri, depth - plate_t - 1.0).arc_to(ri - 0.6, depth - plate_t - 0.2, ri - 2.0, depth - plate_t)
    .hline_to(0).close();
prof.to_face().revolve("Z", 360)
