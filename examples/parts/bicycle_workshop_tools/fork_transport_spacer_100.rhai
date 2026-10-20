// Fork dropout transport spacer for 100 mm quick-release forks: 15 mm tube 100 mm over the end faces, 19 mm end flanges 3 mm thick, 9.5 mm stubs 4 mm long that locate in the dropouts, 5.3 mm skewer bore through
let spacing = 100.0; // [90.0, 110.0] Dropout spacing (mm)
let tube_d = 15.0; // [12.0, 20.0] Tube diameter (mm)
let flange_d = 19.0; // [16.0, 26.0] Flange diameter (mm)
let stub_d = 9.5; // [8.0, 9.8] Stub diameter (mm)
const flange_t = 3.0;
const stub_len = 4.0;
const bore = 5.3;
let rt = tube_d / 2.0;
let rf = flange_d / 2.0;
let rs = stub_d / 2.0;
let rb = bore / 2.0;
let l = spacing;
let profile = polygon([
    [rb, 0, -stub_len], [rs, 0, -stub_len], [rs, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [rt, 0, flange_t],
    [rt, 0, l - flange_t], [rf, 0, l - flange_t], [rf, 0, l], [rs, 0, l], [rs, 0, l + stub_len], [rb, 0, l + stub_len]
]);
profile.to_face().revolve("Z", 360.0).rotate_y(90.0)
