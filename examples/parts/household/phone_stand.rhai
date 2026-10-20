// Phone stand: 70 mm wide, 65 degree back rest 100 mm long, 12 mm lip, cable slot, 4 mm thick plates
let width = 70.0; // [50.0, 120.0] Width (mm)
let angle = 65.0; // [45.0, 80.0] Back rest angle (degrees)
let back = 100.0; // [60.0, 160.0] Back rest length (mm)
let thickness = 4.0; // [3.0, 8.0] Thickness (mm)
let a = angle * PI() / 180.0;
let base = box(80.0, width, thickness);
let rest = box(back, width, thickness).rotate_y(-angle).translate([20.0, 0, thickness]);
let support = box(thickness, width, back * a.sin() * 0.7).translate([80.0 - thickness, 0, 0]);
let lip = box(thickness, width, 12.0).translate([20.0 - thickness - 6.0, 0, 0]);
let stand = fuse_all([base, rest, support, lip]);
stand - box_centered(14.0, 12.0, 40.0).translate([20.0, width / 2.0, 0])
