// Upper thread tension disc: dished steel disc 18 mm across, 0.8 mm thick, 6.5 mm bore, 1.25 mm wide flat round the bore and a 1.6 mm high cone out to the rim
let outer_d = 18.0; // [12.0, 24.0] Disc diameter (mm)
let bore = 6.5; // [4.0, 8.0] Bore diameter (mm)
let thickness = 0.8; // [0.5, 1.2] Disc thickness (mm)
let dish = 1.6; // [0.8, 2.5] Dish height (mm)
let rb = bore / 2.0;
let rf = rb + 1.25;
let ro = max(outer_d / 2.0, rf + 2.0);
let profile = polygon([
    [rb, 0, 0], [rf, 0, 0], [ro, 0, dish], [ro, 0, dish + thickness], [rf, 0, thickness], [rb, 0, thickness]
]);
profile.to_face().revolve("Z", 360.0)
