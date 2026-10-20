// Dummy hub chain keeper for 130 mm quick-release frames: 18 mm axle tube 130 mm long with a 9.5 mm bore for the skewer, 40 mm chain roller 8 mm wide with a 3 mm deep V groove near the drive-side end, 1 mm end chamfers
let spacing = 130.0; // [100.0, 148.0] Hub spacing (mm)
let tube_d = 18.0; // [14.0, 22.0] Tube diameter (mm)
let roller_d = 40.0; // [30.0, 50.0] Roller diameter (mm)
let roller_w = 8.0; // [6.0, 12.0] Roller width (mm)
const bore = 9.5;
const groove = 3.0;
let rt = tube_d / 2.0;
let rr = roller_d / 2.0;
let x0 = spacing - 20.0;
let profile = polygon([
    [bore / 2.0, 0, 0], [rt - 1.0, 0, 0], [rt, 0, 1.0],
    [rt, 0, x0], [rr, 0, x0], [rr - groove, 0, x0 + roller_w / 2.0], [rr, 0, x0 + roller_w], [rt, 0, x0 + roller_w],
    [rt, 0, spacing - 1.0], [rt - 1.0, 0, spacing], [bore / 2.0, 0, spacing]
]);
profile.to_face().revolve("Z", 360.0).rotate_y(90.0)
