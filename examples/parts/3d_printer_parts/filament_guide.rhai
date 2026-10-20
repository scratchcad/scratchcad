// Filament guide clip for 2020: snaps into the slot, 8 mm ring with a 3 mm PTFE-friendly bore, 30 mm arm
let arm = 30.0; // [15.0, 60.0] Arm length (mm)
let ring_d = 10.0; // [6.0, 16.0] Ring diameter (mm)
let bore = 3.0; // [2.0, 5.0] Filament bore (mm)
let clip = box_centered(10.0, 5.8, 6.0).translate([0, 0, 3.0]) + box_centered(10.0, 10.0, 1.5).translate([0, 0, 6.75]);
let beam = box(arm, 4.0, 4.0).translate([-arm, -2.0, 6.0]);
let ring = cylinder([-arm, -2.0, 8.0], "Y", ring_d / 2.0, 4.0) - cylinder([-arm, -3.0, 8.0], "Y", bore / 2.0, 6.0);
fuse_all([clip, beam, ring])
