// Class 66 plastic bobbin: 20.6 mm across the flanges, 9.2 mm wide, flanges 1.2 mm at the core tapering to 0.8 mm at the rim, 8.6 mm core, 6.0 mm spindle bore with 0.3 mm chamfers
let flange_d = 20.6; // [18.0, 24.0] Flange diameter (mm)
let width = 9.2; // [7.5, 11.0] Overall width (mm)
let core_d = 8.6; // [7.5, 11.0] Core diameter (mm)
let bore = 6.0; // [5.0, 6.5] Spindle bore (mm)
const root_t = 1.2;
const rim_t = 0.8;
let rf = flange_d / 2.0;
let rc = core_d / 2.0;
let rb = bore / 2.0;
let profile = polygon([
    [rb + 0.3, 0, 0], [rf, 0, 0], [rf, 0, rim_t], [rc, 0, root_t],
    [rc, 0, width - root_t], [rf, 0, width - rim_t], [rf, 0, width], [rb + 0.3, 0, width],
    [rb, 0, width - 0.3], [rb, 0, 0.3]
]);
profile.to_face().revolve("Z", 360.0)
