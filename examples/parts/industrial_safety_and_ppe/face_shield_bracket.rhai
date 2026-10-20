// Face shield hard hat bracket: slot blade 20 x 2.5 x 28 mm, 25 mm pivot disc 5 mm thick with an 8 mm pivot bore and 12 detent notches, 15 mm arm
let blade_width = 20.0; // [15.0, 22.0] Blade width (mm)
let blade_length = 28.0; // [20.0, 40.0] Blade length (mm)
let disc = 25.0; // [20.0, 35.0] Pivot disc diameter (mm)
let bore = 8.0; // [5.0, 10.0] Pivot bore (mm)
let notches = 12; // [8, 24] Number of detent notches
let blade = box_from_corners([-blade_width / 2.0, -2.5, 0], [blade_width / 2.0, 0, blade_length]);
let arm = box_from_corners([-6.0, -5.0, -15.0], [6.0, 0, 0.01]);
let d = cylinder([0, -5.0, -15.0 - disc / 2.0 + 6.0], "Y", disc / 2.0, 5.0);
let cuts = [];
for k in 0..notches {
    let a = k.to_float() * 360.0 / notches.to_float() * PI() / 180.0;
    cuts.push(cylinder([(bore / 2.0 + 3.5) * a.cos(), -6.0, -15.0 - disc / 2.0 + 6.0 + (bore / 2.0 + 3.5) * a.sin()], "Y", 0.8, 2.0));
}
(blade + arm + d) - cylinder([0, -6.0, -15.0 - disc / 2.0 + 6.0], "Y", bore / 2.0, 7.0) - compound(cuts)
