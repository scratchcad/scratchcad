// Aeroponic spray riser lid bushing: top-hat bushing with a 50 mm flange 4 mm thick, a 31.6 mm sleeve 20 mm long through the lid, a 21.6 mm bore for a 1/2 inch PVC riser, and two internal 2 mm O-ring grooves 1.5 mm deep
let riser_od = 21.3; // [16.0, 33.4] Riser pipe diameter (mm)
let sleeve_len = 20.0; // [10.0, 40.0] Sleeve length (mm)
let flange_d = 50.0; // [40.0, 80.0] Flange diameter (mm)
const ft = 4.0;
let rb = riser_od / 2.0 + 0.15;
let rs = rb + 5.0;
let rf = max(flange_d / 2.0, rs + 6.0);
let h = ft + sleeve_len;
let g1 = h * 0.3;
let g2 = h * 0.7;
let pts = [[rb, 0, 0], [rs - 0.6, 0, 0], [rs, 0, 0.6], [rs, 0, sleeve_len], [rf, 0, sleeve_len], [rf, 0, h - 1.0], [rf - 1.0, 0, h], [rb, 0, h],
    [rb, 0, g2 + 1.0], [rb + 1.5, 0, g2 + 1.0], [rb + 1.5, 0, g2 - 1.0], [rb, 0, g2 - 1.0], [rb, 0, g1 + 1.0], [rb + 1.5, 0, g1 + 1.0], [rb + 1.5, 0, g1 - 1.0], [rb, 0, g1 - 1.0]];
face(polygon(pts)).revolve("Z", 360.0)
