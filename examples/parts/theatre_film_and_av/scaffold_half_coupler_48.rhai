// Half coupler (theatre / scaffold clamp): clamp jaw for 48.3 mm tube, 40 mm wide, 6 mm strap, hinged at one side (8 mm pin bore), swing-bolt slot 14 mm wide at the other, 16 mm M12 weld-on bolt boss on the back
let tube = 48.3; // [33.7, 60.3] Tube diameter (mm)
let width = 40.0; // [25.0, 60.0] Jaw width (mm)
let strap = 6.0; // [4.0, 10.0] Strap thickness (mm)
let pin = 8.0; // [6.0, 10.0] Hinge pin bore (mm)
let r = tube / 2.0;
// lower half-jaw: a half ring with two ears
let half = (cylinder([0, -width / 2.0, 0], "Y", r + strap, width) - cylinder([0, -width, 0], "Y", r, width * 2.0)) - box_from_corners([-r - strap - 1.0, -width, 0], [r + strap + 1.0, width, r + strap + 1.0]);
let ear_l = box_from_corners([-r - strap - 14.0, -width / 2.0, -strap], [-r + 1.0, width / 2.0, 0.01]);
let ear_r = box_from_corners([r - 1.0, -width / 2.0, -strap], [r + strap + 14.0, width / 2.0, 0.01]);
let knuckle = cylinder([-r - strap - 8.0, -width / 2.0, -strap / 2.0], "Y", strap, width);
let boss = cylinder([0, 0, -r - strap + 1.0], "-Z", 8.0, 25.0);
let body = half + ear_l + ear_r + knuckle + boss;
let slot = box_from_corners([r + strap + 2.0, -7.0, -strap - 1.0], [r + strap + 20.0, 7.0, 1.0]);
body - slot - cylinder([-r - strap - 8.0, -width, -strap / 2.0], "Y", pin / 2.0, width * 2.0) - cylinder([0, 0, -r - strap - 26.0], "Z", 5.1, 20.0)
